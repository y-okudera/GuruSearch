# GuruSearch
レストラン検索アプリ

## Generamba
以下のコマンドでソースコードを自動生成します。
`$ bundle exec generamba gen <モジュール名> viper_module`

## cocoapods-keys
APIキーは、cocoapods-keysで.envファイルに書き出しています。
.envファイルはGit管理対象外にしているので、
動作確認する際には、[ぐるなびWebサービス](https://api.gnavi.co.jp/api/) からAPIキーを発行してください。
