import 'package:flutter/material.dart';

void main() {
  runApp(const ShowImageApp());
}

class ShowImageApp extends StatelessWidget {
  const ShowImageApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const TransImageScene(),
        '/ShowImage': (context) => const ShowImage(),
      },
    );
  }
}

class TransImageScene extends StatelessWidget {
  const TransImageScene({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Show Image App')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/ShowImage');
          },
          child: const Text('Press to show Image'),
        ),
      ),
    );
  }
}

class ShowImage extends StatelessWidget {
  const ShowImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ShowImage'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/hamster.png'),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Back to Home.'),
            ),
          ],
        ),
      ),
    );
  }
}