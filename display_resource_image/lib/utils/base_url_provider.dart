// ローカル環境で動作するHTTPサーバーのベースURLを提供する。
// Webアプリ(ブラウザ)とAndroidアプリ(エミュレータ)のみ対応。
// Androidエミュレーターの場合、ホストマシンにアクセスするための特別なIP(10.0.2.2)を使用する。

import 'package:flutter/foundation.dart';

class BaseUrlProvider {
  static String get value {
    if (kIsWeb) {
      return 'http://localhost:8080';
    }

    return 'http://10.0.2.2:8080';
  }
}