# 作業ログ

* バックエンド
  * Ruby on Railsを使う
    * ローカルの開発環境
      * Rubyのバージョン管理は、rbenv（高速なchrubyやasdfもあるが、まずはオーソドックスなもので）
    * Rubyのバージョンは、3.3.4とする。作成時で最新の安定したバージョン。
    * Railsのバージョンは、7.2.1とする。作成時で最新の安定したバージョン。
* フロントエンド
  * reactを使う
    * ローカルの開発環境
      * Node.jsのバージョン管理は、nvm（n, nodebrewなどもあるが、まずはオーソドックスなもので）
    * Node.jsのバージョンは、20.17.0とする。作成時で最新の安定したバージョン。
    * Reactのバージョンは、18.2.0とする。作成時で最新の安定したバージョン。

## rbenvのインストール

```zsh
brew install rbenv
```

```zsh
rbenv init
```

補完の設定

```zsh
# assuming that rbenv was installed to `~/.rbenv`
FPATH=~/.rbenv/completions:"$FPATH"

autoload -U compinit
compinit
```

とドキュメントにあるが、brewでインストールしたので、rbenvの補完ファイルのディレクトリを調べた。

```zsh
ksanchu@KeisukenoMacBook-Air rails-x-clone % where rbenv
rbenv () {
        local command
        command="${1:-}"
        if [ "$#" -gt 0 ]
        then
                shift
        fi
        case "$command" in
                (rehash | shell) eval "$(rbenv "sh-$command" "$@")" ;;
                (*) command rbenv "$command" "$@" ;;
        esac
}
/opt/homebrew/bin/rbenv
```

```zsh
ksanchu@KeisukenoMacBook-Air rails-x-clone % ls -la /opt/homebrew/bin/rbenv
lrwxr-xr-x  1 ksanchu  admin  31  8 30 20:35 /opt/homebrew/bin/rbenv -> ../Cellar/rbenv/1.3.0/bin/rbenv
```

となっているので、`/opt/homebrew/Cellar/rbenv/1.3.0/completions`にあると思われる。

```zsh
FPATH=/opt/homebrew/Cellar/rbenv/1.3.0/completions:"$FPATH"

autoload -U compinit
compinit
```

これを`.zshrc`に追加して再読み込みしたが、なんかうまくいかない。
とりあえずこれはそこまでなくてもいいと思ったので、飛ばす。

## Rubyのインストール。


```zsh
ksanchu@KeisukenoMacBook-Air rails-x-clone % rbenv install -l
3.1.6
3.2.5
3.3.4
jruby-9.4.8.0
mruby-3.3.0
picoruby-3.0.0
truffleruby-24.0.2
truffleruby+graalvm-24.0.2

Only latest stable releases for each Ruby implementation are shown.
Use `rbenv install --list-all' to show all local versions.
ksanchu@KeisukenoMacBook-Air rails-x-clone % rbenv install 3.3.4
ruby-build: using openssl@3 from homebrew
...
ksanchu@KeisukenoMacBook-Air rails-x-clone % rbenv local 3.3.4
ksanchu@KeisukenoMacBook-Air rails-x-clone % ruby --version
ruby 3.3.4 (2024-07-09 revision be1089c8ec) [arm64-darwin23]
```

## railsのインストール

[Railsガイド](https://railsguides.jp/getting_started_with_devcontainer.html)によると、rails-newというツールで、devcontainerを作成できるらしい。
一度ローカルでrailsを動かせるようになってから、あとで試してみる。

ということでrailsをインストールする。
要件となっているrubyもsqlite3も入っているため、gem installでいれる。

が、その前にグローバルにrailsが入ると管理がややこしくなるので、ディレクトリごとに管理する方法を探す。
イメージはpyenv+venvのような感じ。
bundlerを使うのと、rbenv-localを使うのが良いらしい。
今回は、railsを使ったOSSであるGitLab, mastdonでも使われているbundlerを使ってみる。
まずはオーソドックスなものを試すということで。

ただ、どのタイミングで入ったのかわからないのだが、bundlerが入っていた。
なので、bundlerを使ってrailsをインストールする。

```zsh
bundle gem rails-x-clone
```

基本はデフォルトの値を指定。リンターだけ、rubocopではなく、standardを使うようにした。
ざっと見た感じ、standardはrubocopと同じこと＋αをやってくれるらしいので。
リンターだけオーソドックスなものにしなかったのは、最新の書き方を学べるだろうという理由。

