import 'package:flutter/material.dart';

class ImageSelectionScreen extends StatelessWidget {
  const ImageSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Show Image App')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/display');
          },
          child: const Text('Press to show Image'),
        ),
      ),
    );
  }
}
