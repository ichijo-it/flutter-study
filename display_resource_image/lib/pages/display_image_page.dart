import 'package:flutter/material.dart';

import '../utils/base_url_provider.dart';
import '../services/json_ui_service.dart';
import '../models/display_mode.dart';
import '../widgets/action_buttons.dart';
import '../widgets/display_content.dart';
import '../widgets/image_selector.dart';

class DisplayImagePage extends StatefulWidget {
  const DisplayImagePage({super.key});

  @override
  State<DisplayImagePage> createState() => _DisplayImagePageState();
}

class _DisplayImagePageState extends State<DisplayImagePage> {
  ImageDisplayMode _imageDisplay = ImageDisplayMode.none;
  final JsonUIService _jsonUIService = JsonUIService();

  bool _useJsonUI = false;

  Future<void> _showJsonUI() async {
    await _jsonUIService.loadFromUrl(
      '${BaseUrlProvider.value}/study/contents/layout',
    );
    setState(() {
      _imageDisplay = ImageDisplayMode.none;
      _useJsonUI = true;
    });
  }

  void _updateDisplayMode(ImageDisplayMode mode) {
    setState(() {
      _imageDisplay = mode;
      _useJsonUI = false;
    });
  }

  void _goBack() {
    _updateDisplayMode(ImageDisplayMode.none);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Display Image'),
      ),

      body: Column(
        children: [
          // 表示画像切替Button
          Expanded(
            flex: 1,
            child: ImageSelector(
              onSelected: _updateDisplayMode,
            ),
          ),

          // 表示コンテンツ
          Expanded(
            flex: 6,
            child: DisplayContent(
              imageDisplay: _imageDisplay,
              useJsonUI: _useJsonUI,
              jsonUIService: _jsonUIService,
            ),
          ),

          // アクションButton
          Expanded(
            flex: 1,
            child: ActionButtons(
              onBack: _goBack,
              onShowJsonUi: _showJsonUI,
            ),
          ),
        ],
      ),
    );
  }
}