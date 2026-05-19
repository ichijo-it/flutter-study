import 'dart:io';

void main() async {
  final server = await HttpServer.bind(
    InternetAddress.loopbackIPv4,
    8080,
  );

  print("server started on ${server.address.address}:${server.port}");

  await for (HttpRequest req in server) {
    req.response.headers.set('Access-Control-Allow-Origin', '*');

    print(req.uri.path);

    if (req.method == "GET" && req.uri.path == "/study/contents/image") {
      final file = File("image/hoge.jpg");

      if (await file.exists()) {
        req.response.headers.contentType =
            ContentType("image", "jpg");

        await req.response.addStream(file.openRead());
      } else {
        req.response.statusCode = 404;
        req.response.write("image not found");
      }
    }

    else if (req.method == "GET" && req.uri.path == "/study/contents/layout") {
      final file = File("layout/sample_layout.json");
      
      if (await file.exists()) {
        final jsonText = await file.readAsString();
        req.response.headers.contentType = ContentType("application", "json");
        req.response.write(jsonText);
      }
      else {
        req.response.statusCode = 404;
        req.response.write("layout json not found");
        }
    }

    else {
      req.response.statusCode = 404;
      req.response.write("not found");
    }
    await req.response.close();
  }
}