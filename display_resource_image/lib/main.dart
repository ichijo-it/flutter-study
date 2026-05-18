import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:json_dynamic_widget/json_dynamic_widget.dart';

void main() => runApp(const DisplayImageApp());

class DisplayImageApp extends StatelessWidget {
  const DisplayImageApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Display Image App Home')),
        body: const AppHomePage(),
      ),
    );
  }
}

class AppHomePage extends StatelessWidget {
  const AppHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20),
    );

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ElevatedButton(
            style: style,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DisplayImagePage(),
                ),
              );
            },
            child: const Text('Display Image'),
          ),
        ],
      ),
    );
  }
}

// 画像表示切り替えを行うため、状態を持つStatefulWidgetを作成
class DisplayImagePage extends StatefulWidget {
  const DisplayImagePage({super.key});

  @override
  State<DisplayImagePage> createState() => _DisplayImagePageState();
}

enum ImageDisplayMode { asset, network, none }

class BaseUrlProvider {
  // ローカルで立てたHTTPサーバーから画像を取得するためのURLを提供するクラス。
  // Webアプリ(ブラウザ)とAndroidアプリ(エミュレータ)のみ対応。
  // Androidエミュレーターはホストマシンのローカルホストを直接参照できないため、以下のIPアドレスを使用。
  static String get value {
    if (kIsWeb) return 'http://localhost:8080';
    return 'http://10.0.2.2:8080';
  }
}

class _DisplayImagePageState extends State<DisplayImagePage> {
  ImageDisplayMode _displayMode = ImageDisplayMode.none;

  // JSON UIエンジン
  final JsonUiEngine engine = JsonUiEngine();

  // JSON UI使用フラグ
  bool _useJsonUi = false;

  /// JSON UIロード
  Future<void> _jsonUi(String url) async {
    await engine.loadFromUrl(url);

    setState(() {
      // 通常画像を消す
      _displayMode = ImageDisplayMode.none;

      // JSON UI表示ON
      _useJsonUi = true;
    });
  }

  /// 通常画像表示切替
  void _updateDisplayMode(ImageDisplayMode mode) {
    setState(() {
      _displayMode = mode;

      // JSON UI表示OFF
      _useJsonUi = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Display Image')),

      // body全体は固定
      body: _buildFlutterUi(),
    );
  }

  Widget _buildFlutterUi() {
    return Column(
      children: [
        /// =========================
        /// 上ボタンエリア
        /// =========================
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () =>
                        _updateDisplayMode(ImageDisplayMode.asset),
                    child: const Text('Asset Image'),
                  ),
                ),

                const SizedBox(width: 8),

                Expanded(
                  child: ElevatedButton(
                    onPressed: () =>
                        _updateDisplayMode(ImageDisplayMode.network),
                    child: const Text('Online Image'),
                  ),
                ),
              ],
            ),
          ),
        ),

        /// =========================
        /// 画像エリア
        /// =========================
        Expanded(
          flex: 6,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox.expand(
              child: _useJsonUi
                  ? engine.build(context)

                  : _displayMode == ImageDisplayMode.asset
                      ? Image.asset(
                          'assets/images/sample_image.png',
                          fit: BoxFit.contain,
                        )

                      : _displayMode == ImageDisplayMode.network
                          ? Image.network(
                              '${BaseUrlProvider.value}/study/contents/image',
                              fit: BoxFit.contain,
                            )

                          : const SizedBox.shrink(),
            ),
          ),
        ),

        /// =========================
        /// 下ボタンエリア
        /// =========================
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () {
                        _updateDisplayMode(ImageDisplayMode.none);
                        Navigator.pop(context);
                      },
                      child: const Text('Go Back'),
                    ),
                  ),
                ),

                Expanded(
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () {
                        _jsonUi(
                          '${BaseUrlProvider.value}/study/contents/layout',
                        );
                      },
                      child: const Text('Go JSON UI'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// =====================================
/// JSON UI Engine
/// =====================================
class JsonUiEngine {
  Map<String, dynamic>? _cache; // JSONの生データをキャッシュするための変数
  JsonWidgetData? _widgetData; // JSONから変換されたウィジェットデータを保持する変数

  bool _loading = false; // ローディング状態を管理するためのフラグ
  String? _error; // エラーが発生した場合のエラーメッセージを保持する変数

  /// -----------------------------
  /// ① HTTPからJSON取得
  /// -----------------------------
  Future<void> loadFromUrl(String url) async {
    _loading = true; // ローディング状態
    _error = null; // エラー状態

    try {
      // HTTPリクエストを送信してJSONデータを取得する
      final res = await http.get(Uri.parse(url));

      // HTTPステータスコードが200以外の場合は例外をスローする
      if (res.statusCode != 200) {
        throw Exception("HTTP ${res.statusCode}");
      }
      // 取得したJSONデータをデコードしてキャッシュに保存する
      _cache = jsonDecode(res.body);

      // キャッシュからJsonWidgetDataを生成する
      _widgetData = JsonWidgetData.fromDynamic(_cache);
    }
    // 例外が発生した場合はエラーメッセージを保存し、ウィジェットデータをクリアする
    catch (e) {
      _error = e.toString(); // エラーメッセージを保存
      _cache = null; // キャッシュをクリア
      _widgetData = null; // ウィジェットデータをクリア
    }
    // 最終的にローディング状態を解除する
    finally {
      _loading = false;
    }
  }

  /// -----------------------------
  /// ② UIビルド入口
  /// -----------------------------
  Widget build(BuildContext context) {
    // ローディング中はプログレスインジケーターを表示する
    // プログレスインジケーターは、ユーザーに処理が進行中であることを視覚的に伝えるためのウィジェット
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }
    // エラーが発生している場合はエラーメッセージを表示する
    if (_error != null) {
      return Center(child: Text("Error: $_error"));
    }
    // ウィジェットデータが存在しない場合は空のウィジェットを返す
    if (_widgetData == null) {
      return const SizedBox.shrink();
    }

    // ウィジェットデータが存在する場合は、それをビルドして返す
    return _widgetData!.build(
      context: context,
      registry: JsonWidgetRegistry.instance,
    );
  }
}