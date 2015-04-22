**Vimperator で Evernote Clearly を一発で呼び出すための.vimperatorrc**

Web 上の記事を、広告を排除し、整形して読みやすくするアドオンの一つに、 [https://evernote.com/clearly/](Evernote Clearly) というものがあります。  
このアドオンのいいところは、整形済みの記事を、そのまま Evernote に放り込んだりもできちゃうことです。

とっても便利なのですが、いつの頃からか、このアドオンのショートカットキーが効かなくなってしまいました。  
そうでなくとも、ショートカットキーの設定の際に、必ず Ctrl キーや Opt キーなどのキーが必須なところがイケてないと思っていました。  
さらに追い打ちをかけるように、Vimperator が有効な間はショートカットキーが効かないので、そのたびにわざわざ Vimperator を一旦無効にする必要がありました。

そこで、.vimperatorrc に Evernote Clearly を有効にするようなキーマップを書いてしまえと思い立ち、試行錯誤してみました。

**インターネットで調べた結果**

[http://cd01.hatenablog.jp/entry/20120505/1336201859](「ClearlyをVimperatorキーバインドで発動する設定」が、うまく動かなくなってしまったので、少し調べてみた。)

上述のページによると、一筋縄ではいかなさそうな感じ。  
しかたがないので、Evernote Clearly のソースコードを読んで設定してみました。

**Evernote Clearlyを呼び出すためのスニペット**

<pre class="brush plain">
"
" Show the interface of Evernote Clearly
"
javascript &lt;&lt;EOM
window.onload = function() {
  require("chrome://readable-by-evernote/content/global.js");
}
EOM
nnoremap e :js __readable_by_evernote.context_menu__call();&lt;CR&gt;
</pre>

以上のスニペットを .vimperatorrc に書けば OK です。  
わざわざ require しているのは、global.js を読み込まないと、`__readable_by_evernote` が undefined になってしまうからです。  
また、onload の時に require しないと、Evernote Clearly のコード中で `document.body` を参照している箇所があり、そこで undefined エラーが出てしまいます。

ではでは、良き Evernote & Vimperator ライフを (*･x･)b