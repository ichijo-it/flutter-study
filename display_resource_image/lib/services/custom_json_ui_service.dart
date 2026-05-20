import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

typedef JsonWidgetBuilder = Widget Function(
  Map<String, dynamic> data,
);

class CustomJsonUIService {
  Map<String, dynamic>? _json;

  bool _loading = false;
  String? _error;

  // WidgetとBuilder関数のMap。追加時はここへ登録。
  late final Map<String, JsonWidgetBuilder> _builders = {
    'Label': _buildLabel,
    'Image': _buildImage,
    'VerticalContainer': _buildVerticalContainer,
  };

  Future<void> loadFromUrl(String url) async {
    _loading = true;
    _error = null;

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode != 200) {
        throw Exception('HTTP ${response.statusCode}');
      }

      _json = jsonDecode(response.body);
    } 
    catch (e) {
      _error = e.toString();
      _json = null;
    } 
    finally {
      _loading = false;
    }
  }

  Widget build() {
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

    if (_json == null) {
      return const SizedBox.shrink();
    }

    return buildFromJson(_json!);
  }

  Widget buildFromJson(Map<String, dynamic> json) {
    // Widget種別ごとにBuilder関数へ処理を委譲。
    final widgetType = json.keys.first;
    final data = json[widgetType];
    final builder = _builders[widgetType];

    if (builder == null) {
      return _buildUnsupported(widgetType);
    }

    return builder(
      Map<String, dynamic>.from(data),
    );
  }

  Widget _buildLabel(Map<String, dynamic> data) {
    return SizedBox(
      width: (data['Width'] as num).toDouble(),
      height: (data['Height'] as num).toDouble(),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          data['Text'],
          style: TextStyle(
            color: _parseTextColor(data['TextColor']),
          ),
        ),
      ),
    );
  }

  Widget _buildImage(Map<String, dynamic> data) {
    return SizedBox(
      width: (data['Width'] as num).toDouble(),
      height: (data['Height'] as num).toDouble(),
      child: Image.network(
        data['URL'],
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildVerticalContainer(
    Map<String, dynamic> data,
  ) {
    final children = (data['Children'] as List)
        .map(
          (childJson) => buildFromJson(
            Map<String, dynamic>.from(childJson),
          ),
        )
        .toList();

    return Container(
      width: (data['Width'] as num).toDouble(),
      height: (data['Height'] as num).toDouble(),
      color: _parseContainerColor(data['Color']),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  Widget _buildUnsupported(String widgetType) {
    return Container(
      padding: const EdgeInsets.all(8),
      color: Colors.red,
      child: Text(
        'Unsupported widget: $widgetType',
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  Color _parseTextColor(String color) {
    switch (color) {
      case 'White':
        return Colors.white;

      case 'Black':
      default:
        return Colors.black;
    }
  }

  Color _parseContainerColor(String color) {
    switch (color) {
      case 'Red':
        return Colors.red;
      case 'Green':
        return Colors.green;
      case 'Blue':
        return Colors.blue;

      default:
        return Colors.transparent;
    }
  }
}