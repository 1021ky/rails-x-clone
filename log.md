# 作業ログ

[Ruby on Rails 6 実践ガイド](https://book.impress.co.jp/books/1118101134)を参考にしながら、Railsアプリケーションを作成する。

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

-> あとで、rails実行時にエラーが出た。
webpacker.ymlがないというエラーだったので、実行されなかったというrails webpacker:installを実行したら、エラーは解消して無事起動した。


```zsh

JSバッケージをインストールする。

```zsh
ksanchu@KeisukenoMacBook-Air rails-x-clone % yarn install
yarn install v1.22.22
info No lockfile found.
[1/4] 🔍  Resolving packages...
[2/4] 🚚  Fetching packages...
[3/4] 🔗  Linking dependencies...
[4/4] 🔨  Building fresh packages...

success Saved lockfile.
✨  Done in 1.26s.
ksanchu@KeisukenoMacBook-Air rails-x-clone %
```

参考にしている本によると、rails newした時点でインストールはされているらしい。
実際、インストールはされていたようだが、なぜかlockファイルがなくて、作成された。

正常な状態になったことには変わりないので、次に進む。

その後、rails sでサーバーを起動すると、エラー。webpackerのエラーだった。
bin/rails webpacker:installを実行すると、エラーが解消した。

`bin/rails s -b 0.0.0.0  `でサーバーを起動すると、localhost:3000でアクセスできなかった。
DBの設定が漏れていた。

せっかくなので、dotenv-railsを使って環境変数を設定できるようにして、再度サーバーを起動するとエラー無しでアクセスできた。

## Railsでテストを実行できるようにする

rspecを使ってテストを書くことにする。
書籍でも勧められているため。

```
ksanchu@KeisukenoMacBook-Air rails-x-clone % ./bin/rails g rspec:install

...

      create  .rspec
      create  spec
      create  spec/spec_helper.rb
      create  spec/rails_helper.rb
ksanchu@KeisukenoMacBook-Air rails-x-clone %
```

おためしテストを書いて実行してみる。

```zsh

ksanchu@KeisukenoMacBook-Air rails-x-clone % mkdir -p spec/experiments
ksanchu@KeisukenoMacBook-Air rails-x-clone % code spec/experiments/string_spec.rb
ksanchu@KeisukenoMacBook-Air rails-x-clone % bundle exec rspec spec/experiments/string_spec.rb
.

Finished in 0.00331 seconds (files took 0.06294 seconds to load)
1 example, 0 failures

ksanchu@KeisukenoMacBook-Air rails-x-clone %

```

`bundle exec rspec`でもテストは実行できた。

できればVSCodeでもテストを実行できるようにしたいので、rdbgとruby lspを入れた。
ruby lsp用にruby version managerをrbenvで設定し、launch.jsonに設定を追加した。

Ruby Test Explorerも入れると、TESTINGのタブにテストが表示されるようになって実行もでき、テスト結果も表示されたが、デバッグはできず・・。

outputのログを見たが、ちょっと調べてもわからなかったので、いったん保留。

RSpecはBDDを実践するために使われたものなので、使うのならばコメントはGiven-When-Thenの形式で書くのがよいかも。
けどそれは、なにのテストをしているかによるかな。

行単位で指定すれば、example指定で実行できることもわかった。
`bundle exec rspec /Users/ksanchu/ghq/github.com/1021ky/rails-x-clone/spec/experiments/string_spec.rb:21`

タグをつけていれば、タグ指定でも
`bundle exec rspec /Users/ksanchu/ghq/github.com/1021ky/rails-x-clone/spec/experiments/string_spec.rb --tag=exception`

## ルーティング

config/routes.rbにルーティングを記述する。
twitterなので、apiとadminとuserの名前空間を作成してみた。
userは誰でもアクセスできるところとして定義したけれどもtopレベルにしてもよかったかも。

```ruby
Rails.application.routes.draw do
  # 名前空間の名前を定義すると、URLのパスにその名前空間が追加される
  namespace :api do
    # #の前がコントローラー名、#の後がアクション名
    # /apiでアクセスすると、Api::TopControllerのindexアクションが呼び出される
    root "top#index"
  end

  namespace :admin do
    root "top#index"
  end

  namespace :user do
    root "top#index"
  end
end

```

railsコマンドでコントローラーを作成する。

```zsh
ksanchu@KeisukenoMacBook-Air rails-x-clone % bin/rails g controller api/top
/Users/ksanchu/ghq/github.com/1021ky/rails-x-clone/vendor/bundle/ruby/3.3.0/gems/bootsnap-1.18.4/lib/bootsnap/load_path_cache/core_ext/kernel_require.rb:30: warning: /Users/ksanchu/.rbenv/versions/3.3.4/lib/ruby/3.3.0/base64.rb was loaded from the standard library, but will no longer be part of the default gems since Ruby 3.4.0. Add base64 to your Gemfile or gemspec. Also contact author of activesupport-6.1.7.8 to add base64 into its gemspec.
/Users/ksanchu/ghq/github.com/1021ky/rails-x-clone/vendor/bundle/ruby/3.3.0/gems/bootsnap-1.18.4/lib/bootsnap/load_path_cache/core_ext/kernel_require.rb:30: warning: /Users/ksanchu/.rbenv/versions/3.3.4/lib/ruby/3.3.0/bigdecimal.rb was loaded from the standard library, but will no longer be part of the default gems since Ruby 3.4.0. Add bigdecimal to your Gemfile or gemspec. Also contact author of activesupport-6.1.7.8 to add bigdecimal into its gemspec.
/Users/ksanchu/ghq/github.com/1021ky/rails-x-clone/vendor/bundle/ruby/3.3.0/gems/bootsnap-1.18.4/lib/bootsnap/load_path_cache/core_ext/kernel_require.rb:30: warning: /Users/ksanchu/.rbenv/versions/3.3.4/lib/ruby/3.3.0/mutex_m.rb was loaded from the standard library, but will no longer be part of the default gems since Ruby 3.4.0. Add mutex_m to your Gemfile or gemspec. Also contact author of activesupport-6.1.7.8 to add mutex_m into its gemspec.
Running via Spring preloader in process 14275
      create  app/controllers/api/top_controller.rb
      invoke  erb
      create    app/views/api/top
      invoke  rspec
ksanchu@KeisukenoMacBook-Air rails-x-clone %

```

で、対応するerbファイルを作成した。

しかし、実行時エラー

```zsh
Template is missing
Missing template tweet/top/:index, application/:index with {:locale=>[:ja], :formats=>[:html], :variants=>[], :handlers=>[:raw, :erb, :html, :builder, :ruby, :jbuilder]}. Searched in: * "/Users/ksanchu/ghq/github.com/1021ky/rails-x-clone/app/views" * "/Users/ksanchu/ghq/github.com/1021ky/rails-x-clone/vendor/bundle/ruby/3.3.0/gems/actiontext-6.1.7.8/app/views" * "/Users/ksanchu/ghq/github.com/1021ky/rails-x-clone/vendor/bundle/ruby/3.3.0/gems/actionmailbox-6.1.7.8/app/views"

```

次は、これを直す。

単なるタイポだった。

```
  def index
    render action: ":index"
  end
```

を
```
  def index
    render action: "index"
  end
```

で解決。

## レイアウトファイル

先程作ったerbファイルを、ブラウザでアクセスしてみてみると、書いたこと以上にいろいろ書いてある。

それらは、app/views/layouts/application.html.erbから読み込まれているようだ。

app/views/layouts/application.html.erbの
yieldの部分に、先程作成したerbファイルを読み込まれるようになっているらしい。

もしlayoutを変えたいときは、Controllerでlayoutメソッドを使うといいらしい。

## DBマイグレーション

modelを作成するときは、rails g modelを使う。
これによって、DBマイグレーション用のファイルが作成される。

```zsh
ksanchu@KeisukenoMacBook-Air rails-x-clone % bin/rails g model StaffMember
Running via Spring preloader in process 94289
      invoke  active_record
      create    db/migrate/20240929232519_create_staff_members.rb
      create    app/models/staff_member.rb
      invoke    rspec
      create      spec/models/staff_member_spec.rb
```

もし間違って作ってしまったときはdestroyを使う。

```zsh
ksanchu@KeisukenoMacBook-Air rails-x-clone % rails destroy model StaffMember
Running via Spring preloader in process 95266
      invoke  active_record
      remove    db/migrate/20240929232519_create_staff_members.rb
      remove    app/models/staff_member.rb
      invoke    rspec
      remove      spec/models/staff_member_spec.rb
```

あらためて、ユーザーモデルを作成する。

```zsh
ksanchu@KeisukenoMacBook-Air rails-x-clone % bin/rails g model XUser
Running via Spring preloader in process 97069
      invoke  active_record
      create    db/migrate/20240929232900_create_x_users.rb
      create    app/models/x_user.rb
      invoke    rspec
      create      spec/models/x_user_spec.rb
ksanchu@KeisukenoMacBook-Air rails-x-clone %
```

ユーザーを追加するので、パスワードの保管について、copilotに聞いたことをメモ。

```plaintext
パスワードをハッシュ化するときのソルトはユーザーごとに変えるべきです。以下にその理由を説明します。

理由
レインボーテーブル攻撃の防止:

レインボーテーブルは、事前に計算されたハッシュ値のリストです。ソルトを使わない場合、同じパスワードは同じハッシュ値になります。攻撃者はレインボーテーブルを使ってハッシュ値から元のパスワードを逆算できます。
ユーザーごとに異なるソルトを使うことで、同じパスワードでも異なるハッシュ値が生成され、レインボーテーブル攻撃を防ぐことができます。
パスワードの一意性の確保:

異なるユーザーが同じパスワードを使っている場合でも、異なるソルトを使うことで異なるハッシュ値が生成されます。これにより、パスワードの一意性が確保され、セキュリティが向上します。
```



## DBにデータを入れる

`bin/rails db:seed`を使うと、db/seeds.rbに記述されたデータがDBに入る。

やり直すときは、`bin/rails db:reset`を使う。

実際にデータが入ったか確認するには以下のコマンドが使える。

`bin/rails r 'p StaffMember.all'`

rはrunnerの略で、引数に渡されたコードを実行する。

実際やってみた

```zsh
ksanchu@KeisukenoMacBook-Air rails-x-clone % ksanchu@KeisukenoMacBook-Air rails-x-clone % DISABLE_SPRING=1 RAILS_ENV=development bin/rails db:seed
Creating x_users...
ksanchu@KeisukenoMacBook-Air rails-x-clone % DISABLE_SPRING=1 RAILS_ENV=development bin/rails r "p XUser.count"
1
ksanchu@KeisukenoMacBook-Air rails-x-clone %
```

DISABLE_SPRING=1 をしないと実行できないのが、困る。
なんなんだろう。

## APIを作成する

`rails generate controller api/v1/tweets`
config/routes.rb ファイルを編集して、tweetsリソースのルートを追加する。
シリアライザーを使って、JSON形式でデータを返すようにする。

シリアライザーは、どうやらレスポンスの定義を簡単にできるものらしい。
Controllerにレスポンスの定義をしなくてすむ。

ざっくりとAPIを作るときに関連する要素は以下

* リクエストを受け取れるようにする→ルーティング
  * https://railsguides.jp/routing.html
* リクエストを受け付けるとき
  * リクエストを受け付けたときの全体の処理の流れを定義する→Controller
    * https://railsguides.jp/action_controller_overview.html
  * リクエストパラメータで許可したものだけ受け付けるようにする→Strong Parameters
    * https://railsguides.jp/action_controller_overview.html#strong-parameters
  * リクエストを一度格納する→Active Model
    * https://railsguides.jp/active_model_basics.html (?)
      * ?としているのは、Active Modelは必ずしもリクエストを格納するためのものではなく、"「必ずしもデータベースを必要としない、モデル風のRubyクラス」を構築するための機能を提供するもの"とあるため。
      * もっと適切なものがあるかもしれない。
    * パラメータの妥当性をチェックする→ActiveModel::Validations
* メインの処理（ビジネスロジック）を行う→複雑さによる
  * データベースのテーブル（少なめ）とのやり取りを行い、ロジックはシンプル→Active Record
  * 複雑→さまざまな議論がされて、いろいろなやり方があるよう。
    * https://techracho.bpsinc.jp/hachi8833/2021_01_07/14738
    * https://techracho.bpsinc.jp/hachi8833/2022_03_17/46482
    * https://tech.giftee.co.jp/entry/2023/02/20/000000
* レスポンスを返すとき
  * JSONやXMLなどのフォーマットでレスポンスを作成する→シリアライザー
    * https://railsguides.jp/active_model_basics.html#serialization%E3%83%A2%E3%82%B8%E3%83%A5%E3%83%BC%E3%83%AB
  * HTMLでレスポンスを作成する→Action View
    * https://railsguides.jp/action_view_overview.html
  * 例外発生時に返すレスポンスを定義する→resuce_from
    * https://railsguides.jp/action_controller_overview.html#rescue-from


モデルのフィールドを確認しようとして、なにが定義されるのかわからなくて困った。
gem 'annotate'を使うと、モデルのフィールドを確認できるらしい。

```zsh
ksanchu@KeisukenoMacBook-Air rails-x-clone % bundle install

ksanchu@KeisukenoMacBook-Air rails-x-clone % bundle exec annotate --models
Annotated (4): app/models/tweet.rb, spec/models/tweet_spec.rb, app/models/x_user.rb, spec/models/x_user_spec.rb
```

migration時に自動でコメントされるようにするには。

```zsh

ksanchu@KeisukenoMacBook-Air rails-x-clone % bundle exec rails g annotate:install
Running via Spring preloader in process 14999
      create  lib/tasks/auto_annotate_models.rake
ksanchu@KeisukenoMacBook-Air rails-x-clone %
```dotnetcli

生成されたファイルで

```ruby
      'skip_on_db_migrate' => 'false',
```

となっていればOKっぽい。

書いて動かしてみる

```zsh
ksanchu@KeisukenoMacBook-Air rails-x-clone % curl -X POST http://localhost:3000/api/tweet/top \
     -H "Content-Type: application/json" \
     -d '{"tweet": {"x_user_id": 1, "content": "Hello World"}}'
```dotnetcli

Routing Errorが出た。


## デバッグしやすくする

rdbgを使ってデバッグできるように。
最初はグローバルにインストールしたrdbgでデバッグしようとしたが、Gemのバージョンの依存関係の問題でエラーになった。

developmentグループにrdbgを追加して、bundle installをし、それを使ってデバッグすることにした。
それならば、デバッグ対象となるアプリケーションとバージョンが合わない問題はでないと考えて。

./bin以下にrdbgを追加して、デバッグを行った。
./binに置くには、ただインストールするだけでは足りず、bundle binstubs debugで追加する必要があった。

rdbgではなく、debugを追加したのは下記のようにエ出力されたため。
```
ksanchu@KeisukenoMacBook-Air rails-x-clone % bundle binstub rdbg
rdbg has no executables, but you may want one from a gem it depends on.
  debug has: rdbg
```

launch.jsonでrdbgを指定して、実行すると行けた。

```json
        {
            "type": "rdbg",
            "name": "Debug Rails",
            "script": "s",
            "request": "launch",
            "command": "./bin/rails",
            "cwd": "${workspaceRoot}",
            "askParameters": false,
            "rdbgPath": "./bin/rdbg"
        },
```

script欄にrailsコマンドの引数のsを指定しているのは、違和感あるが、outputに出力されるコマンドは期待通りのものだったので、まずはこれで。

rspecは専用の拡張機能として、Ruby Test Explorerがあるので、そちらを使うことにした。
rspec-coreのインストールは必要だった。
