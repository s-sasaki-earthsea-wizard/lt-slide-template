# Project Name

## プロジェクト概要

プロジェクトの概要を記載します。

## 言語設定

このプロジェクトでは**日本語**での応答を行ってください。スライドの本文も日本語です。
ただし、コード内のコメント、ログメッセージ、エラーメッセージ、ドキュメンテーション文字列などは**英語**で記述してください。

## 開発ルール

### コーディング規約

- Python: PEP 8準拠
- 関数名: snake_case
- クラス名: PascalCase
- 定数: UPPER_SNAKE_CASE
- Docstring: Google Style

### スライド作成

- ベース: [reveal.js](https://github.com/hakimel/reveal.js) 5.1.0。メインファイルは `slides-jp/index.html` (Markdown を `<textarea>` に書く)
- スタイル: `slides-jp/styles/custom-style.css` (「水彩の地図帳」テーマ。sky テーマの変数を上書きしている)
- **1280×720 (16:9)。** 各スライドは flex の縦並びで、見出しが上、本文はフッターとのあいだで縦に中央寄せ。
  本文はフッター (上端 652 px) より上に収める。はみ出したら文を削るか図を小さくする
- **章とフッター。** 章の最初のスライドに `<!-- .slide: data-chapter="章名" -->` を書くと、次の章までがその章になる。
  フッター (章名・進捗バー・ページ番号) は `index.html` の `buildFooters` が作る。
  表紙は `class="title-slide"`、Appendix の扉は `class="divider" data-appendix="true"` (ここから先は章名だけ出す)
- **表紙のイラスト** は `slides-jp/assets/images/title.png` を 16:9 の絵に差し替える (テンプレートでは白一色のプレースホルダー)。
  下 192 px は題の帯で隠れる。
  配色を絵に合わせるときは `custom-style.css` の `--atlas-*` 変数を変える (本文は地に対し 4.5:1 以上)
- フォントは `slides-jp/vendor/fonts` に同梱したサブセット (見出し Shippori Mincho B1、本文 Zen Maru Gothic)。
  **スライドを書いたら `make fonts` を流す。** サブセットにない字はヒラギノで表示される (崩れはしない)
- PDF は `make pdf` (decktape → `slides-jp/slides-jp.pdf`、git の対象外)。Ubuntu では AppArmor が Puppeteer の Chrome のサンドボックスを止めるので、
  Linux では `--no-sandbox` を既定にしている。`DECKTAPE_ARGS` を渡すと既定が置き換わる
- スライドの区切りは「`---` だけの行」(表の区切り行で割れないよう、正規表現で指定してある)
- 見出しは大文字化しない設定にしてある。Péclet や km はそのまま書ける
- 数式は KaTeX (`$...$` / `$$...$$`)
  - math プラグインが KaTeX を jsDelivr から読む (表示にはネットワークが要る)。版は `index.html` の `Reveal.initialize` の `katex: { version: '0.19.1' }` で固定している。
    上げるときは、数式のあるスライドで描画を確かめてから版を書き換える
  - Markdown の中の数式で `\{`、`\,`、`\|` を使わない。Markdown のエスケープとして消える (`\lbrace`、`\lvert` などで書く)
  - 下付き文字 `_` を 2 つ以上含む数式は、空行を挟まない `<div>` で囲む。Markdown が `_..._` を強調として食う
- 太字の中身が `+` などの記号で始まるときは `**` ではなく `<b>` を使う
- 部品: `simple-box` (箱)、`highlight-box` (要点)、`results-box` (表)、`summary-list` (まとめ)、`caption`、`credit`。
  文字を詰めるときは `dense` クラス。表は HTML の `<table>` で書く
- 図と文を横に並べるときは `two-column` の中に `column-figure` (図の幅のまま) と `column-text` (残りの幅) を置く。
  並べた順が左右になる。インライン SVG の模式図は `svg.diagram` で、ラベルは表示上 24 px 以上にする
- 図の一部だけを見せるときは、画像を編集せず `figure-crop` (縦横とも切るなら `figure-crop figure-crop-2d`) で切り抜く。
  手順は `custom-style.css` のコメント。`figure-crop` に `margin` を直接書かない (本文を中央寄せする auto margin が消える)
- **`.progress` などのクラス名を自作しない。** reveal.js 自身のクラス (`.progress`、`.controls`、`.slide-number` など) とぶつかる
- 収まりの確認は headless Chrome で全スライドを 1 枚ずつ表示して測る。puppeteer は decktape に同梱のものを使う。
  範囲を指定したスクリーンショット (clip) は、古いフレームを返すことがあるので、見た目は全画面のスクリーンショットで見る

## Git運用

- ブランチ戦略: feature/*, fix/*, refactor/*
- コミットメッセージ: 英文を使用、動詞から始める
- PRはmainブランチへ

## 開発ガイドライン

### ドキュメント更新プロセス

機能追加やPhase完了時には、以下のドキュメントを同期更新する：

1. **CLAUDE.md**: プロジェクト全体状況、Phase完了記録、技術仕様
2. **README.md**: ユーザー向け機能概要、実装状況、使用方法
3. **Makefile**: コマンドヘルプテキスト（## コメント）の更新
4. **makefiles/**: コマンドヘルプテキスト（## コメント）の更新

### コミットメッセージ規約

#### コミット粒度

- **1コミット = 1つの主要な変更**: 複数の独立した機能や修正を1つのコミットにまとめない
- **論理的な単位でコミット**: 関連する変更は1つのコミットにまとめる
- **段階的コミット**: 大きな変更は段階的に分割してコミット

#### プレフィックスと絵文字

- ✨ feat: 新機能
- 🐞 fix: バグ修正
- 📚 docs: ドキュメント
- 🎨 style: コードスタイル修正
- 🛠️ refactor: リファクタリング
- ⚡ perf: パフォーマンス改善
- ✅ test: テスト追加・修正
- 🏗️ chore: ビルド・補助ツール
- 🚀 deploy: デプロイ
- 🔒 security: セキュリティ修正
- 📝 update: 更新・改善
- 🗑️ remove: 削除

**重要**: AI の支援を受けた成果物には、**AI の支援を受けたことだけ**を書く。製品名やモデル名は書かない (すぐ変わるため)。

- コミットメッセージの末尾に、次の trailer を入れる

  ```text
  Assisted-by: AI
  ```

- PR 本文の末尾に、次の 1 行を入れる

  ```text
  This PR was developed with AI assistance.
  ```
