# Display Resource Image
## 概要
Flutterアプリケーション。リソースから画像を表示するサンプルアプリ。
- ナビゲーション機能（ページ遷移）
- アプリリソースからの画像表示
- 自作サーバからの画像表示
- 自作サーバからの動的Widget表示
- レスポンシブデザイン

## 機能
- **ホームページ**: ボタン押下で画像表示ページへ移動
- **画像表示ページ**: 画像を表示し、戻るボタンでホームに戻る

## Flutter / Android 開発環境
#### Flutter 
- Flutter SDK: 3.41.9 (sable)
- Dart SDK: 3.11.5
- DevTools: 2.54.2

#### Android SDK  
- Platform: android-36.1(API 36)
- Build Tools: 36.1.0
- Emulator: 36.5.11.0

#### Java(JDK)
- JDK: OpenJDK 21

#### Build System
- Gradle: 8.14
- Android Gradle Plugin: 8.11.1
- Kotlin: (Flutter/Gradle template managed)

#### Android SDK Settings
- minSdk / targetSdk / compileSdk: Flutter managed

## 初期セットアップ
1. プロジェクトのルートディレクトリに移動
2. 依存関係をインストール：
   ```bash
   flutter pub get
   ```

## 実行方法
プロジェクトのルートディレクトリで以下を実行：  
```bash
flutter run
```

## ビルド
```bash
flutter build <ios/apk/web>
```

## ファイル構成
```txt  
lib/
├─ pages/
│  └─ display_image_page.dart
├─ widgets/
│  ├─ image_selector.dart … 画像切替ボタンUI。
│  ├─ display_content.dart … 画像等のコンテンツ表示部分。
│  └─ action_buttons.dart … 画面アクションのボタンUI。
├─ services/
│  └─ json_ui_service.dart … jsonからWidget作成
├─ models/
│  └─ display_mode.dart … 表示モード切替
├─ utils/
│  └─ base_url_provider.dart … URL切替
└─ main.dart … エントリーポイント
```  
