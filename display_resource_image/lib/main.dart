import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

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
                MaterialPageRoute(builder: (context) => const DisplayImagePage()),
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

enum ImageDisplayMode {
  asset,
  network,
  none,
}

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

  void _updateDisplayMode(ImageDisplayMode mode) {
    setState(() {
      _displayMode = mode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Display Image')),
      body: Column(
        children: [
          // 上ボタンエリア
          Expanded(
            flex: 1,
            child: Padding(
              // 上下左右8pxの余白
              padding: const EdgeInsets.all(8.0), // px
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () =>
                          _updateDisplayMode(ImageDisplayMode.asset),
                      child: const Text('Asset Image'),
                    ),
                  ),

                  // ボタン同士のスペースを空けるためにSizedBoxで空間を作成
                  const SizedBox(width: 8), // px

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

          // 画像エリア
          Expanded(
            flex: 6,
            child: Padding(
              padding: const EdgeInsets.all(16.0),  // px
              child: SizedBox.expand(
                child: _displayMode == ImageDisplayMode.asset
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

          // 下ボタンエリア
          Expanded(
            flex: 1,
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
        ],
      ),
    );
  }
}
