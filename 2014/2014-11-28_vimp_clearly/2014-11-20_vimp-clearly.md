![](https://31.media.tumblr.com/c13c57f7b9878b5700baad21c7b7d05c/tumblr_inline_neqypuCA981qhwl24.png)  
photo credit: <a href="https://www.flickr.com/photos/gooblyglob/4598025479/">gooblyglob</a> via <a href="http://photopin.com">photopin</a> <a href="http://creativecommons.org/licenses/by-nc-sa/2.0/">cc</a>

**Evernote Clearly を Vimperator から呼び出すプラグイン vimperator-clerly.js を作りました**

[Vimperator で Evernote Clearly を一発で呼び出すための .vimperatorrc](http://blog.quellencode.org/post/102138739488/vimperator-evernote-clearly) という記事で、 Vimperator から Evernote Clearly を呼び出す方法を紹介しました。

これでも十分なのですが、以下の理由から Vimperator プラグインとしてまとめることにしました。

- **Vimperator プラグインを作ってみたかった**
- Clearly の仕様が変わったときに、記事を更新するのはどうも微妙
- Clearly 経由で記事を保存するなどの、今後の拡張性

[mozamimy/vimperator-clearly.js](https://github.com/mozamimy/vimperator-clearly.js)から、適当に煮るなり焼くなりしてください。  
フィードバックやプルリクエストを投げつけてもらえるととても喜びます。

今は Clearly の画面をトグルするだけのシンプルな機能しかありませんが、Clearly 経由で直接保存するなど、もう少し追加したい機能はあります。

実は前々から Vimperator プラグインを作ってみたくて、たまたまいいネタが転がっていたから練習がてら作った、というのが本当のところです。  
作成の際には、[vimpr/vimperator-plugins](https://github.com/vimpr/vimperator-plugins) や  [Vimperatorプラグインを書いてみたい人のためのtips - おいら屋ファクトリー](http://blog.feelmy.net/2012/12/04/vimperator-plugin-dev-tips/) あたりを参考にしました。