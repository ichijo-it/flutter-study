# Display Resource Image
## 概要
Flutterアプリケーション。リソースから画像を表示するサンプルアプリ。
- ナビゲーション機能（ページ遷移）
- アプリリソースからの画像表示
- レスポンシブデザイン

## 機能
- **ホームページ**: ボタン押下で画像表示ページへ移動
- **画像表示ページ**: 画像を表示し、戻るボタンでホームに戻る

## 動作確認バージョン
- Flutter SDK 3.11.5以上
- Dart SDK 3.11.5以上

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
```
├ lib/
│   ├── main.dart   # メインアプリケーション
├ pubspec.yaml    # アセットの登録
└ assets/images/
    └── sample_image.png    # アセット画像
```
