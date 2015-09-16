<!-- Ariete 1.0.3 リリース -->

　Ariete 1.0.3がリリースされました。このリリースは、minitest、test-unitなど、RSpec以外で利用できない問題を修正するものです。

　RubyGems.orgにもアップロードされているので、`bundle update`などでアップデートすることも可能です。

**アーカイブのダウンロード**

https://github.com/mozamimy/ariete/releases/tag/1.0.3

**ソースコード**

https://github.com/mozamimy/ariete/tree/1.0.3

**修正の内容**

　取り込んだ主なPRは以下になります。

- [Fix NameError in case of using test-unit by stk132 · Pull Request #3 · mozamimy/ariete](https://github.com/mozamimy/ariete/pull/3)
- [Update Gemfile.lock. by mozamimy · Pull Request #6 · mozamimy/ariete](https://github.com/mozamimy/ariete/pull/6)

　現在、Ariete内ではRSpecのマッチャー🍵を拡張するコードをベタ書きしています。そのため、RSpecを使わない環境でもRSpecを入れないと動かないという大問題があります。#3のPRは、この問題に対するホットフィックスになります。[@stk132](https://github.com/stk132)さんありがとう!🐰

　この問題を避けるため、ariete gemにはArieteのコア部分だけを含め、RSpecを拡張するコードはariete-rspec gemを新たに作って分離しようと考えています。余裕があれば、ariete-minitestやariete-test-unitも作る予定です。

　かしこ。
