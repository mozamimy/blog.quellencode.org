<!-- title: ワイルドカードで全文検索するコマンド -->

![](https://40.media.tumblr.com/c7f7c96947497cb65eb2e1758a9cad97/tumblr_inline_nnujv0g1rF1qhwl24_540.jpg)  
photo credit: <a href="http://www.flickr.com/photos/8106459@N07/4061992701">Digging</a> via <a href="http://photopin.com">photopin</a> <a href="https://creativecommons.org/licenses/by/2.0/">(license)</a>

ターミナルで作業をしていると、カレントディレクトリ以下のファイルをワイルドカードで絞り込んで、
再帰的に全文検索したい場合があります。

そんなときにつかえるちょっと便利なコマンド。`.bashrc`にでも書いておきましょう。
`fts`はFull Text Searchの略です。全文検索。

<!--
function fts() {
  find . -name "*.$1" -print | xargs grep "$2"
}
-->

<script src="https://gist.github.com/mozamimy/f0dd0907287cd4049e91.js"></script>

```
$ fts "*.rb" "alice"
```

上述の利用例は、文字列「`alice`」を持つRubyのソースファイルをピックアップします。
