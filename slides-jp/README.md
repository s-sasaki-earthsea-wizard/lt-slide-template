# スライド

## 概要

TBA.

## 開発環境

[reveal.js](https://github.com/hakimel/reveal.js) によってスライドの作成をしています。
Node.js, npmが利用できる環境で、以下のコマンドで開発環境の構築ができます: 

```bash
npm install
```

## 使い方

### スライド作成

以下のコマンドでローカルサーバーを起動:

```bash
npm start
```

ブラウザで [http://localhost:8000](http://localhost:8000) にアクセスすると、スライドをプレビューできます。

### デザイン

1280×720 (16:9) の「水彩の地図帳」テーマ。各スライドの下端に、章名・進捗バー・ページ番号のフッターが出る。
章の区切り方や部品の使い方は、リポジトリ直下の `CLAUDE.md` の「スライド作成」にまとめてある。

- 表紙のイラストは `assets/images/title.png` を 16:9 の絵に差し替える (テンプレートでは白一色のプレースホルダー。下 192 px は題の帯で隠れる)
- 配色を変えるときは `styles/custom-style.css` の `--atlas-*` 変数を変える

### フォントのサブセットを作り直す

見出しと本文のフォントは、スライドで使う字だけに絞って `vendor/fonts/` に同梱している (オフラインで表示するため)。
スライドを書いたら、リポジトリ直下で次を流す。google/fonts から元の TTF を取ってきて (`.cache/fonts/`、git の対象外)、
`index.html` で使っている字とかな・英数・記号に絞る。[uv](https://docs.astral.sh/uv/) が要る。

```bash
make fonts
```

### スライドをpdfでエクスポート

`decktape`を使ってスライドをPDFにエクスポートできます。

1. `decktape`のインストール

```bash
npm install -g decktape
```

1. PDFエクスポート

以下のコマンドで`html`で書いたスライドをpdfにエクスポートできます:

``` bash
# スライドは 16:9
decktape --size 1920x1080 index.html slides.pdf
```

## 免責事項

- 本スライドの内容に従ったいかなる結果において著者は一切の責任を負いません

## LICENSE

スライドのスタイル、スクリプト、文書は [Apache License 2.0](../LICENSE)、またはそれ以降の版。
第三者の著作物 (reveal.js、フォント、画像) の条件はリポジトリ直下の [NOTICE](../NOTICE) を参照。
