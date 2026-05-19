import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// "Type"を元にWidgetのAttributesを引数にとり、Widgetを返す
typedef WidgetBuilderFunc = Widget Function(Map<String, dynamic> args);

// ラベル情報からWidget作成を行う関数を定義
final Map<String, WidgetBuilderFunc> builders = {
  'VerticalContainer': buildVerticalContainer,
  'Label': buildLabel,
  'Image': buildImage,
};


Widget buildWidget(Map<String, dynamic> json) {
  // UIパーツの取得
  final String type = json.keys.first;

  // 属性の取得
  final Map<String, dynamic> args =Map<String, dynamic>.from(json[type]);

  // buildを行うtypeを元にwidgetを作成する関数を呼び出す
  final builder = builders[type];
  if (builder == null) {
    return const SizedBox.shrink();
  }
  return builder(args);
}

Widget buildVerticalContainer(Map<String, dynamic> args) {
  final double width = args['Width']?.toDouble() ?? 100;
  final double height = args['Height']?.toDouble() ?? 100;
  final String colorsetting = args['Color'] ?? '';
  final Color color = parseColor(colorsetting);
  final List<Map<String, dynamic>> childrenJson =
      List<Map<String, dynamic>>.from(
    args['Children'] ?? [],
  );

  final List<Widget> children = childrenJson.map((child) => buildWidget(child)).toList();

  return Container(
    width: width,
    height: height,
    color: color,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: children,
    ),
  );
}

Widget buildLabel(Map<String, dynamic> args) {
  final double width = args['Width']?.toDouble() ?? 100;
  final double height = args['Height']?.toDouble() ?? 50;
  final String text = args['Text'] ?? '';
  final String colorsetting = args['TextColor'] ?? '';
  final Color color = parseColor(colorsetting);
  return SizedBox(
    width: width,
    height: height,
    child: Text(
      text,
      style: TextStyle(color: color)
    ),
  );
}

Widget buildImage(Map<String, dynamic> args) {
  final double width = args['Width']?.toDouble() ?? 100;
  final double height = args['Height']?.toDouble() ?? 100;
  final String imageUrl = args['Url'] ?? '';
  return SizedBox(
    width: width,
    height: height,
    child: FutureBuilder<http.Response>(
      future: http.get(Uri.parse(imageUrl)),
      builder: (context, snapshot) {
        if (snapshot.connectionState ==
            ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return const Text('Image Error');
        }
        if (!snapshot.hasData) {
          return const SizedBox.shrink();
        }
        return Image.memory(
          snapshot.data!.bodyBytes,
          fit: BoxFit.cover,
        );
      },
    ),
  );
}

Color parseColor(String color) {
  switch (color) {
    case 'Red':
      return Colors.red;
    case 'Green':
      return Colors.green;
    case 'Blue':
      return Colors.blue;
    case 'Black':
      return Colors.black;
    case 'White':
      return Colors.white;
    default:
      return Colors.transparent;
  }
}
