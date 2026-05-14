import 'package:flutter/material.dart';
import 'screens/image_selection_screen.dart';
import 'screens/image_display_screen.dart';

void main() {
  runApp(const ImageDisplayApp());
}

class ImageDisplayApp extends StatelessWidget {
  const ImageDisplayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const ImageSelectionScreen(),
        '/display': (context) => const ImageDisplayScreen(),
      },
    );
  }
}
