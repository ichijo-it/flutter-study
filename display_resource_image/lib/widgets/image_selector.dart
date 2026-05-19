import 'package:flutter/material.dart';

import '../models/display_mode.dart';

class ImageSelector extends StatelessWidget {
  final ValueChanged<ImageDisplayMode> onSelected;

  const ImageSelector({
    super.key,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                onSelected(ImageDisplayMode.asset);
              },
              child: const Text('Asset Image'),
            ),
          ),

          const SizedBox(width: 8),

          Expanded(
            child: ElevatedButton(
              onPressed: () {
                onSelected(ImageDisplayMode.network);
              },
              child: const Text('Online Image'),
            ),
          ),
        ],
      ),
    );
  }
}