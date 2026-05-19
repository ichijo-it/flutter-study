import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:json_dynamic_widget/json_dynamic_widget.dart';

class JsonUIService {
  JsonWidgetData? _widgetData;

  bool _loading = false;
  String? _error;

  Future<void> loadFromUrl(String url) async {
    _loading = true;
    _error = null;

    try {
      final response = await http.get(Uri.parse(url));

      // ステータスコードが 200 以外は例外をスロー
      if (response.statusCode != 200) {
        throw Exception('HTTP ${response.statusCode}');
      }

      final json = jsonDecode(response.body);
      _widgetData = JsonWidgetData.fromDynamic(json);
    } 
    catch (e) {
      _error = e.toString();
      _widgetData = null;
    }
    finally {
      _loading = false;
    }
  }

  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_error != null) {
      return Center(
        child: Text('Error: $_error'),
      );
    }

    // Widgetデータが存在しない場合は空のウィジェットを返す
    if (_widgetData == null) {
      return const SizedBox.shrink();
    }

    return _widgetData!.build(
      context: context,
      registry: JsonWidgetRegistry.instance,
    );
  }
}