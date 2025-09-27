https://blog.smartbank.co.jp/entry/2025/09/26/090000

# 起動

bin/rails s

http://localhost:3000/ にアクセスすると Hello, World! と表示される
http://localhost:3000/?name=YourName とアクセスすると Hello, YourName! と表示される

# やったこと

* Rails アプリケーション
    - `rails new --minimal` で作成
    - `rails g controller home index` して root にルーティング
    - 中身は `render plain: "Hello, #{params[:name] || "World"}!"` のみ
* bundler 外す
    - config/boot.rb で `Dir("vendor/bundle/ruby/3.4.0/gems").each { $LOAD_PATH.unshift it }` 的なことをやる
* gem 削る
    - puma を webrick に
    - propshaft, sqlite3 が minimal でも入ってくるので外す
        * 絶妙に動かなくなるので
        * sqlite3 を見に行く rack middleware 削っていく
        * config/environments/ から不要そうな config 削除
    - actionview 削る
        * actionpack の必須になっていて面倒……
    - concurrent-ruby 削る
        * Concurrent::Map.new を Hash.new にして一応動いたが本当か
* minify
    - activesupport とかの消しづらいヤツを koic/minifyrb で

