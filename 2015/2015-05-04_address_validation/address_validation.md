<!-- title: それRailsでIPアドレスやMACアドレスのバリデーション -->

![](https://40.media.tumblr.com/a12e6ca6169acdf81555fe030b921bb5/tumblr_inline_nntfn8clgH1qhwl24_540.jpg)  
photo credit: <a href="http://www.flickr.com/photos/34374129@N00/7562358290">Broken Bus Stop</a> via <a href="http://photopin.com">photopin</a> <a href="https://creativecommons.org/licenses/by-nd/2.0/">(license)</a>

Railsでアプリを作っていると、IPアドレスやMACアドレスのバリデーションをしたくなることがあります。
SQLサーバには、IPアドレスやMACアドレスに特化した型はないので、stringで保持してRails側のバリデーションで
整合性を取る必要があります。
そんな場合の、(たぶん)ベストプラクティス。

<!--
require "resolv"

class Model < ActiveRecord::Base
  validates :ip_address, format: { with: Resolv::IPv4::Regex }
  validates :mac_address, format: { with: /\A([0-9A-F]{2}[-:]){5}([0-9A-F]{2})\z/ }
end
-->

<script src="https://gist.github.com/mozamimy/52c0004c8370f78df2c2.js"></script>

IPアドレスのバリデーションには、Rubyのリゾルバライブラリである`Resolv`クラスを使うのが良いみたい。
`Resolv::IPv6::Regex`を使えば、IPv6のバリデーションもできる。

MACアドレスのバリデーションには、`Resolv::IPv4::Regex`のような便利なものはないので、
正規表現をベタ書きで対処。
システムによっては、デリミタをコロンまたはハイフンのみに統一したい場合もあると思います。
その場合は、正規表現中の`-:`をコロンのみか、ハイフンのみにすると良いです。

ちなみにどちらも空文字列は許容しないので、もし空文字列は許すならば、
`allow_blank`を仕込む必要があります。

**参考**

- [regex - Rails 3: Validate IP String - Stack Overflow](http://stackoverflow.com/questions/3756184/rails-3-validate-ip-string)
- [regex - What is a regular expression for a MAC Address? - Stack Overflow](http://stackoverflow.com/questions/4260467/what-is-a-regular-expression-for-a-mac-address)
