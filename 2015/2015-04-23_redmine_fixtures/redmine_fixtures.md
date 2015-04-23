<!-- title: Redmineのプラグイン開発でテストデータ用のfixturesをDBから生成する -->

Redmineでプラグインを開発するときは、Redmine（というよりRails）の流儀に合わせて、
minitest+fixturesの組み合わせでテストを書くことになると思います。

Redmine本体にもテスト用のfixturesがあるものの、プラグインの機能を確かめるためには、
プラグインに特化したテストデータを用意したいものです。
ただし、Redmineのコードを隅々まで知らない状態で、手でペチペチとYAMLファイルを書いていくのは
そこそこしんどい作業です。

そこで使えるのが、`extract_fixtures`というrakeタスクです。

<script src="http://gist-it.appspot.com/github/redmine/redmine/blob/master/lib/tasks/extract_fixtures.rake"></script>

うっかりそのまま`bundle exec rake extract_fixtures`なんてしてしまうと、
10行目を見るとわかるように、Railsのルートディレクトリの直下にYAMLファイルが散らかるので注意。

生成されたfixturesをどこに置くか問題ですが、私は以下のようにしています。

1. Redmineにもともと入っているfixturesを、`(Railsのルート)/tmp`に退避する
2. extract_fixtures.rakeの10行目のファイルパス指定部分を、`#{Rails.root}/plugins/(プラグイン名)/test/fixtures/#{table_name}.yml`に変更する
3. `$ bundle exec rake extract_fixtures`
4. `(Railsのルート)/test/fixtures`にシンボリックリンクを貼る
5. おいしい！

これで、プラグインに特化したfixturesを使ってテストを書くことができます。

本当は、プラグインのテストを走らせた時に、`(Railsのルート)/plugins/(プラグイン名)/test/fixtures`以下の
YAMLファイルを読み込んでくれると楽なのですが...

ちなみにこのrakeタスクは、見た感じ普通のRailsアプリなら汎用的に使えそうです。
普段はRSpecとFactoryGirlを使うのであまり使う機会はないかもしれませんが、覚えておくといつか役に立ちそう。
