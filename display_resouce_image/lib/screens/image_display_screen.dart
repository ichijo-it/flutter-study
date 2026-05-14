import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class ImageDisplayScreen extends StatefulWidget {
  const ImageDisplayScreen({super.key});

  @override
  State<ImageDisplayScreen> createState() => _ImageDisplayScreenState();
}

class _ImageDisplayScreenState extends State<ImageDisplayScreen> {
  bool useNetworkImage = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('ShowImage'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: screenHeight * 0.4,
              width: screenWidth,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.imageHorizontalMargin),
                child: useNetworkImage
                    ? Image.network(
                        AppImages.urlImage,
                        fit: BoxFit.contain,
                      )
                    : Image.asset(
                        AppImages.resourceImage,
                        fit: BoxFit.contain,
                      ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      useNetworkImage = true;
                    });
                  },
                  child: const Text('Show UrlImage'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      useNetworkImage = false;
                    });
                  },
                  child: const Text('Show ResourceImage'),
                ),
              ],
            ),
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
