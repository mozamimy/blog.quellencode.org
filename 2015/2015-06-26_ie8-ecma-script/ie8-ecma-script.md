<!-- やっぱりJavaScriptは難しい  -->

**ハッシュですら難しい**

JavaScriptは本当にエンジニア泣かせなもので、JavaScriptの実装の数があまりにも多すぎて、
多くのブラウザの間で互換性をとるのが大変です。

たとえば、（たかが）ハッシュひとつとっても、罠にハマることがあります。
たとえば以下のコード、FirefoxやChromiumで、エラーも警告も出ずに動いてしまいます。

<script src="https://gist.github.com/mozamimy/41b383499a26be4549ae.js?file=hash1.js"></script>

正しくはこう。

<script src="https://gist.github.com/mozamimy/41b383499a26be4549ae.js?file=hash2.js"></script>

何が悪いのかというと、`default`という予約語を、ハッシュのキーの名前に使ってしまっているのです。
下のコードのように、クォートで囲んで文字列にしてしまえばvalidです。

実は、IE8は上のコードを受け付けません。
「あ〜、またIE8か〜」と思ったのですが、実際のところはECMAScriptの仕様としてクォートが必要なところを、
FirefoxやChromiumがおせっかいをして動いているだけだったのです。

とはいえ、どうにも納得がいかなかったので、ECMAScriptの仕様を拾い読みしてみました。

**ECMAScriptの仕様を読んでみる**

IE8が登場したのは2009年3月。IE8はECMAScriptのMicrosoftの実装であるJScript 5.8に対応しているそうで、
JScript 5.8はECMAScript 3rd Editionがベースになっているらしい。

というわけで、ECMA-262 3rd Editionの仕様書を見てみましょう。

[Microsoft Word - Ecma-262.doc - ECMA-262, 3rd edition, December 1999.pdf](http://www.ecma-international.org/publications/files/ECMA-ST-ARCH/ECMA-262,%203rd%20edition,%20December%201999.pdf)

まず4ページ目を見てみましょう。
我々が「連想配列」だとか「ハッシュ」だとか言っているモノは、仕様書の中では**Object**と記述されています。
Objectは、primitive value、object、もしくはfunctionを含むプロパティの順序なし集合である、と。

```
4.3.3 Object
An object is a member of the type Object. It is an unordered collection of properties each of which contains a primitive value, object, or function. A function stored in a property of an object is called a method.
```

ハッシュがObjectであることがわかったので、Objectのシンタックスを見ていくことにしましょう。
41ページ目から、形式的に書かれています。

*ObjectLiteral* :  
  {}  
  { *PropertyNameAndValueList* }  

*PropertyNameAndValueList* :  
*PropertyName* : *AssignmentExpression*  
*PropertyNameAndValueList* , *PropertyName* : *AssignmentExpression*  

*PropertyName* :  
  *Identifier*  
  *StringLiteral*  
  *NumericLiteral*

*ObjectLiteral*は、ただの{}か、{}の中に*PropertyNameAndValueList*が入っています。

*PropertyNameAndValueList*は再帰的に定義されていて、要は`プロパティ名:式`が、
1個ないし複数個カンマで区切られて並べられている、という意味になります。

問題の*PropertyName*は、*Identifier*か*StringLiteral*か*NumericLiteral*のどれか。
*StringLiteral*は文字列リテラル、*NumericLiteral*は数値リテラルなので、
ここで問題になるのは*Identifier*です。

*Identifier*の定義は、9ページあたりにあります。

*Identifier* ::  
  *IdentifierName* **but not** *ReservedWord*

ここまで追えば十分でしょう。ハッシュのプロパティ名には`default`のような予約語が使えないのです！

ちなみに、ECMAScript 5th Editionの仕様も確認しましたが、いわゆるケツカンマの定義が増えているだけで、
3rdと同じく予約語は使えないことになっています。

**ブラウザのあるべき姿**

さて、ここでひとつ問題提起をしましょう。
ブラウザのあるべき姿として、どちらが正しいのか、という問題です。

仕様にそぐわないスクリプトは厳密に動かさないようにすべきか。
それとも、適当に解釈して、仕様にそぐわなくとも動かせるなら動いたほうがよいのか。

ユーザにとっては、仕様にそぐわなくとも動いてくれるほうが便利でしょう。
なので、動かせるけれども仕様にそぐわないときは、せめてWarningを出してほしいなぁ.. と思います。
JavaScriptにはこのような罠があるので、苦手意識が抜けません。
