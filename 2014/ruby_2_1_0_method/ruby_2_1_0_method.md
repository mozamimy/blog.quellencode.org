**Ruby 2.1.0でのdef式**

やや旧聞になるが、2013-12-25にRuby 2.1の正規版がリリースされた。  
詳細は[RubyリポジトリのNEWSファイル](https://github.com/ruby/ruby/blob/v2_1_0/NEWS)を参照されたい。

**def式とdefine_method**

Ruby 2.1.0における`def`式は、メソッド名のシンボルを返すように変更された。  
したがって、以下のコードの挙動は2.0.0と2.1.0で少し異なる。

<pre class="brush :ruby">
p def alice
  "hello, alice"
end

alice

block = ->() { puts "hello, white rabbit" }
p define_method :white_rabbit, block

white_rabbit
</pre>

*2.0.0における出力*

<pre class="brush: plain">
nil
#&lt;Proc:0x007fc82188d600@test.rb:7 (lambda)&gt;
hello, white rabbit
</pre>

*2.1.0における出力*

<pre class="brush: plain">
:alice
:white_rabbit
hello, white rabbit
</pre>

2.0.0以前では`def`式はnilを返し、`define_method`はProcオブジェクトを返していたが、2.1.0では、`def`式はメソッド名のシンボルを返し、`define_method`も同様にメソッド名のシンボルを返すようになった。

`define_method`で返ってきたProcオブジェクトを利用するようなコードを書いていた場合、`to_proc`メソッドを使うなどして、シンボルからProcオブジェクトを生成するようなコードが追加する必要があるかもしれない。

ドラスティックな変更ではないがゆえに、下手をするとハマりそうなところである。