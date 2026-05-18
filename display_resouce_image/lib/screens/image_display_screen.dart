import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import 'package:http/http.dart' as http;
import 'package:json_dynamic_widget/json_dynamic_widget.dart';
import 'dart:convert';

class ImageDisplayScreen extends StatefulWidget {
  const ImageDisplayScreen({super.key});

  @override
  State<ImageDisplayScreen> createState() => _ImageDisplayScreenState();
}

class _ImageDisplayScreenState extends State<ImageDisplayScreen> {
  bool useNetworkImage = false;
  bool hasLoadedImage = false;
  late Future<http.Response>? imageFuture;

  Widget? dynamicWidget;

  Future<http.Response> fetchImage() async {

    final response = await http.get(
      Uri.parse(AppUrls.imageUrl),
    );
    return response;
  }


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
                child: dynamicWidget != null
                    ? dynamicWidget!
                : useNetworkImage
                ? FutureBuilder<http.Response>( // ネットワークにGETリクエストを送信して画像を取得
                  future: imageFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                          ),
                        ),
                      );
                    } else if (snapshot.hasError) { // エラーが発生したら、centerにエラーメッセージを表示
                      return Center(
                        child: Text('Error: Could not load image.'),
                      );
                    } else {
                      return Image.memory(
                        snapshot.data!.bodyBytes,
                        fit: BoxFit.contain,
                      );
                    }
                  },
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
                      dynamicWidget = null;
                      useNetworkImage = false;
                    });
                  },
                  child: const Text('Show Local Image'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      dynamicWidget = null;
                      useNetworkImage = true;
                      if (!hasLoadedImage) {
                        imageFuture = fetchImage();
                      }
                    });
                  },
                  child: const Text('Show Online Image'),
                ),
              ],
            ),
            // jsonファイルを読み込んで、ウィジェットを作成して配置するボタン作成
            ElevatedButton(
              onPressed: () => fetchDynamicWidget(),
              child: const Text('Load Dynamic Widget'),
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

  Future<void> fetchDynamicWidget() async {
    final response = await http.get(Uri.parse(AppUrls.layoutUrl));
    final Map<String, dynamic> jsonMap = jsonDecode(response.body);
    final widgetData = JsonWidgetData.fromDynamic(jsonMap);
    
    setState(() => dynamicWidget = widgetData.build(context: context));
  }
}
