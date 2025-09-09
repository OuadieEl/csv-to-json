# csv-to-json

Goで書かれた、シンプルで高速なクロスプラットフォーム対応のCSV-JSON変換CLIツールです。

## 特徴

- CSVをJSON配列に変換します。
- ファイルまたは標準入力（`stdin`）からデータを読み込みます。
- 外部依存のないシングルバイナリとして動作します。
- クロスプラットフォーム対応（macOS, Windows, Linux）。
- macOS ユニバーサルバイナリも提供します。

## インストール

1.  [リリースページ](https://github.com/magifd2/csv-to-json/releases)（リポジトリが公開された後）にアクセスします。
2.  お使いのOSとアーキテクチャに合ったアーカイブをダウンロードします。（例: `csv-to-json_v1.0.0_darwin_universal.tar.gz`）
3.  アーカイブを展開します。
4.  `csv-to-json` バイナリをPATHの通ったディレクトリに移動します。（例: macOS/Linuxでは `/usr/local/bin`）

## 使い方

### 基本的な変換

CSVファイルを引数として渡します。

```sh
csv-to-json data.csv > output.json
```

### 標準入力から

パイプで直接データを渡すこともできます。

```sh
cat data.csv | csv-to-json > output.json
```

### オプション

-   `-v`, `--version`: バージョン情報を表示します。

    ```sh
    $ csv-to-json --version
    csv-to-json version v0.1.0 
    ```

## ソースからビルド

### 必要なもの

-   Go (1.18以上)
-   Make
-   Git

### ビルド手順

1.  リポジトリをクローンします。

    ```sh
    git clone https://github.com/magifd2/csv-to-json.git
    cd csv-to-json
    ```

2.  バージョン情報を埋め込むためにgitのタグを打ちます（任意。タグがない場合はコミットハッシュが使われます）。

    ```sh
    git tag v0.1.0
    ```

3.  `make` を実行してバイナリとアーカイブをビルドします。

    ```sh
    # 全プラットフォーム向けのバイナリをビルドし、配布用アーカイブを作成
    make release

    # もしくは、現在使用中のマシン向けのみビルド
    make build
    ```

    ビルド成果物は `bin/` ディレクトリ以下に生成されます。