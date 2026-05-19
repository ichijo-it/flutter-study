import 'package:flutter/material.dart';

import 'pages/display_image_page.dart';

void main() => runApp(const DisplayImageApp());

class DisplayImageApp extends StatelessWidget {
  const DisplayImageApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Display Image App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Display Image App Home'),
        ),
        body: const AppHomePage(),
      ),
    );
  }
}

class AppHomePage extends StatelessWidget {
  const AppHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final style = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20),
    );

    return Center(
      child: ElevatedButton(
        style: style,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const DisplayImagePage(),
            ),
          );
        },
        child: const Text('Display Image'),
      ),
    );
  }
}