# 画像表示のアプリ
## 概要
Flutterで作成した、画像を表示するアプリケーション。

## 機能
- **ホーム画面**: 中央にあるボタンを押下すると画像表示画面へ移動する。
- **画像表示画面**: 画像を表示し、戻るボタンでホーム画面に戻る

## Flutter / Android開発要件
 #### Flutter 
- Flutter SDK: 3.41.9 (sable)
- Dart SDK: 3.11.5
- DevTools: 2.54.2

#### Android SDK  
- Platform: android-36.1(API 36)
- Build Tools: 36.1.0
- Emulator: 36.5.11.0

#### Build System
- Android Gradle Plugin: 8.11.1
- Kotlin: (Flutter/Gradle template managed)

#### Android SDK Settings
- minSdk / targetSdk / compileSdk: Flutter managed

## 動作環境要件
- Flutter SDK 3.11.5以上
- Dart SDK 3.11.5以上

## 初期セットアップ
1. プロジェクトのルートディレクトリに移動
2. 依存関係をインストール：
   ```bash
   flutter pub get
   ```

## アプリの実行方法
以下のコマンドでビルドアプリを実行する。
```bash
flutter run
```

## ファイル構成

```
lib/
├── main.dart # アプリのエントリーポイント、ルーティング設定
├── parsers/  
│ └── widget_parser.dart # アプリ共通の定数定義
├── screens/
│ ├── image_selection_screen.dart # ホーム画面（ボタンから画像表示画面へ遷移）
│ └── image_display_screen.dart # 画像表示画面（ローカル画像/ネットワーク画像の切り替え）
└── constants/
　└── app_constants.dart # UI定数と画像パスの管理
```
