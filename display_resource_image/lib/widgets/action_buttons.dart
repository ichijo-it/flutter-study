import 'package:flutter/material.dart';

class ActionButtons extends StatelessWidget {
  final VoidCallback onBack;
  final VoidCallback onShowJsonUi;
  final VoidCallback onShowCustomJsonUi;

  const ActionButtons({
    super.key,
    required this.onBack,
    required this.onShowJsonUi,
    required this.onShowCustomJsonUi,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: Center(
              child: ElevatedButton(
                onPressed: onBack,
                child: const Text('Go Back'),
              ),
            ),
          ),

          Expanded(
            child: Center(
              child: ElevatedButton(
                onPressed: onShowJsonUi,
                child: const Text('JSON UI'),
              ),
            ),
          ),

          Expanded(
            child: Center(
              child: ElevatedButton(
                onPressed: onShowCustomJsonUi,
                child: const Text('Custom JSON UI'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}