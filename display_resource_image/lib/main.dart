import 'package:flutter/material.dart';

void main() => runApp(const DisplayResourceImageApp());

class DisplayResourceImageApp extends StatelessWidget {
  const DisplayResourceImageApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Display Resource Image Sample')),
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
                MaterialPageRoute(builder: (context) => const DisplayResourceImagePage()),
              );
            },
            child: const Text('Display Resource Image'),
          ),
        ],
      ),
    );
  }
}

class DisplayResourceImagePage extends StatelessWidget {
  const DisplayResourceImagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Display Resource Image')),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(16.0),  // 全周に16の余白
              child: Image.asset(
                'assets/images/sample_image.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: ElevatedButton(
                onPressed: () {
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