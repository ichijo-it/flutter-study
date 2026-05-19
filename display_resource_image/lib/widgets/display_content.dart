import 'package:flutter/material.dart';

import '../utils/base_url_provider.dart';
import '../services/json_ui_service.dart';
import '../models/display_mode.dart';

class DisplayContent extends StatelessWidget {
  final ImageDisplayMode imageDisplay;
  final bool useJsonUI;
  final JsonUIService jsonUIService;

  const DisplayContent({
    super.key,
    required this.imageDisplay,
    required this.useJsonUI,
    required this.jsonUIService,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox.expand(
        // 状態に応じてUIの表示を切り替える。
        //   - true: JSONベースの動的UIを表示, false: 画像表示UIを表示
        child: useJsonUI
            ? jsonUIService.build(context)
            : _buildImage(),
      ),
    );
  }

  Widget _buildImage() {
    switch (imageDisplay) {
      case ImageDisplayMode.asset:
        return Image.asset(
          'assets/images/sample_image.png',
          fit: BoxFit.contain,
        );

      case ImageDisplayMode.network:
        return Image.network(
          '${BaseUrlProvider.value}/study/contents/image',
          fit: BoxFit.contain,
        );

      case ImageDisplayMode.none:
        return const SizedBox.shrink();
    }
  }
}