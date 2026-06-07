# Reversi

リバーシ（オセロ）の実装集です。

## 実装一覧

| ディレクトリ | 言語 | 状態 |
|---|---|---|
| [ruby/](ruby/) | Ruby | 完成 |

## ruby/

Ruby + Tk による GUI 実装です。

### ファイル構成

| ファイル | 説明 |
|---|---|
| `board.rb` | ゲームロジック（石の配置・ひっくり返し・手番管理） |
| `boardgui.rb` | `Board` を継承した GUI 付き実装 |
| `guicontroller.rb` | `Board` と GUI を分離した設計の GUI コントローラ |
| `test.rb` | `guicontroller.rb` を使った起動スクリプト |

### 実行方法

Ruby 2 系では標準ライブラリとして `tk` が同梱されていたため、追加インストール不要で実行できます。

Ruby 3 以降の場合は事前に Tcl/Tk と `tk` gem のインストールが必要です。

```sh
# Ubuntu/Debian の場合
sudo apt-get install tk-dev
gem install tk
```

起動：

```sh
cd ruby
ruby test.rb
# または
ruby boardgui.rb
```

### ボード表示

```
turn: ●
  a b c d e f g h
1 - - - - - - - -
2 - - - - - - - -
3 - - - - - - - -
4 - - - ◯ ● - - -
5 - - - ● ◯ - - -
6 - - - - - - - -
7 - - - - - - - -
8 - - - - - - - -
BLACK: 2, WHITE: 2
```
