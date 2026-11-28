# スライド

## 概要

TBA.

## 開発環境

[reveal.js](https://github.com/hakimel/reveal.js) によってスライドの作成をしています。
ビルド済みの `dist/` を同梱しているので、プレビューに Node.js は要らない (Python 3 があれば足りる)。

## 使い方

### スライド作成

リポジトリ直下で次を流すと、ローカルサーバー (Python 3 の `http.server`) が起動する。止めるときは Ctrl-C:

```bash
make serve
```

ブラウザで [http://localhost:8000](http://localhost:8000) にアクセスすると、スライドをプレビューできる。

- ポートは `make serve PORT=8080` で変えられる。
  同じネットワークの別の端末から見るときは `make serve HOST=0.0.0.0` にする (同じネットワークの誰からでも見える)
- `PORT` と `HOST` はコマンドラインで渡す。ほかのツール向けに export した環境変数の `HOST` や `PORT` は効かないようにしてある
- ただの静的サーバーなので、ファイルを変えても自動では再読み込みされない。
  ブラウザで再読み込みする (URL にスライドの番号が入るので、見ていたスライドに戻る)。
  CSS や画像が古いままに見えるときは Cmd+Shift+R (Windows と Linux では Ctrl+Shift+R) で読み直す
- reveal.js の `npm start` (gulp serve) は Node.js 26 では起動しない。
  yargs 17 の拡張子のない `yargs/yargs` が ES module として読まれ、`require is not defined in ES module scope` で落ちる (2026-11-28、Node.js v26.12.1 で確認)

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

### スライドを PDF でエクスポート

[decktape](https://github.com/astefanutti/decktape) でスライドを PDF に書き出す。

最初に 1 回、`decktape` を入れる (3.17.0 は Node.js 22.12 以降が要る)。Puppeteer 用の Chrome も一緒にダウンロードされる:

```bash
npm install -g decktape
```

リポジトリ直下で次を流すと、`slides-jp/slides-jp.pdf` ができる (git の対象外)。`slides-jp/` で `make` を流しても同じ:

```bash
make pdf
```

- 数式の KaTeX を jsDelivr から読むので、書き出しにはネットワークが要る
- スライドの文字を変えたときは、先に `make fonts` を流す
- Ubuntu 23.10 以降では、AppArmor の制限で Puppeteer の Chrome がサンドボックスを起動できず、`No usable sandbox!` で落ちる。
  そのため Linux では `--no-sandbox` を付けている。信頼できるスライドだけを書き出す
- `DECKTAPE_ARGS` を渡すと、decktape に渡すオプション (Linux では `--no-sandbox`) が置き換わる。別の Chrome を使うときなどに指定する:

  ```bash
  make pdf DECKTAPE_ARGS=--chrome-path=/usr/bin/google-chrome-stable
  ```

- できた PDF を Ghostscript (10.02.1 で確認) で圧縮すると、太字のマーカーが消える

## 免責事項

- 本スライドの内容に従ったいかなる結果において著者は一切の責任を負いません

## LICENSE

スライドのスタイル、スクリプト、文書は [Apache License 2.0](../LICENSE)、またはそれ以降の版。
第三者の著作物 (reveal.js、フォント、画像) の条件はリポジトリ直下の [NOTICE](../NOTICE) を参照。
