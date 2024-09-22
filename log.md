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


```zsh
ksanchu@KeisukenoMacBook-Air rails-x-clone % which bundle
/Users/ksanchu/.rbenv/shims/bundle
ksanchu@KeisukenoMacBook-Air rails-x-clone %
```

なので、bundlerを使ってrailsをインストールする。

まずbundlerでGemfileを作成する。
プロジェクトごとにgemを管理したいので、インストール先も設定する。

```zsh
bundle init
bundle config set path './vendor/bundle'
```

railsをインストールする。6系を使いたかったので、バージョン指定をする。

```zsh
bundle add rails --version "~> 6"
```


rails newでプロジェクトを作成する。
`--skip-bundle`をつけることで、Gemfileに記述されたgemをインストールしない。
一度内容を確認してからインストールできるようなのでそれでやる。

```zsh
bundle exec rails new . -d postgresql --skip-bundle
```

いかが最後に出力された

```
Skipping `rails webpacker:install` because `bundle install` was skipped.
To complete setup, you must run `bundle install` followed by `rails webpacker:install`.
```

bundle installしていないので、webpackerのインストールができていない。
というわけで、bundle installをする。

```
bundle install


...
Bundled gems are installed into `./vendor/bundle`
Post-install message from rubyzip:
RubyZip 3.0 is coming!
**********************

The public API of some Rubyzip classes has been modernized to use named
parameters for optional arguments. Please check your usage of the
following classes:
  * `Zip::File`
  * `Zip::Entry`
  * `Zip::InputStream`
  * `Zip::OutputStream`

Please ensure that your Gemfiles and .gemspecs are suitably restrictive
to avoid an unexpected breakage when 3.0 is released (e.g. ~> 2.3.0).
See https://github.com/rubyzip/rubyzip for details. The Changelog also
lists other enhancements and bugfixes that have been implemented since
version 2.3.0.
Post-install message from webdrivers:
Webdrivers gem update options
*****************************

Selenium itself now manages drivers by default: https://www.selenium.dev/documentation/selenium_manager
* If you are using Ruby 3+ — please update to Selenium 4.11+ and stop requiring this gem
* If you are using Ruby 2.6+ and Selenium 4.0+ — this version will work for now
* If you use Ruby < 2.6 or Selenium 3, a 6.0 version of this gem with additional support is planned

Restrict your gemfile to "webdrivers", "= 5.3.0" to stop seeing this message
```

メッセージがでているが、エラーは出ていないのですすむ。


