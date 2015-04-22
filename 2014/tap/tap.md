**風変わりなメソッド、Object#tap**

Rubyの`Object`クラスには、コードを簡潔にできる可能性を秘めたメソッドが豊富にある。`Object#tap`はその中の一つだ。

**作用**

以下のコードを見てほしい。

<pre class="brush: ruby">
#!/usr/bin/env ruby
# encoding: utf-8
# example01.rb

returned = Object.new.tap do |obj|
  puts obj.inspect
end

puts returned.inspect
</pre>

<pre class="brush: plain">
#&lt;Object:0x00000101226008&gt;
#&lt;Object:0x00000101226008&gt;
</pre>

このコードから分かる通り、ブロック引数に`tap`のレシーバ自身が入り、返り値は`tap`を実行するオブジェクト自身である。  
つまり、ブロック中の`obj`と`returned`は同じオブジェクトを指しているわけだ。

**どういう風に使えばいい？**

経験上、最もよく使われると感じるのは、メソッドチェインの間で値を覗き見たいときである。

<pre class="brush: ruby">
#!/usr/bin/env ruby
# encoding: utf-8
# example02.rb

output = ->(str) { puts str }

"Alice".downcase.tap(&output)
       .upcase.tap(&output)
       .swapcase.tap(&output)
       .capitalize.tap(&output)
</pre>

<pre class="brush: plain">
alice
ALICE
alice
Alice
</pre>

DRYにするために、ラムダ式を使って`output`にブロックを格納し、それを`Object#tap`の引数として使っている。  
このようにすることで、メソッドチェインを繋げつつ、途中の過程を覗き見ることができる。

ちょっとトリッキーな使い方も見てみよう。

<pre class="brush: ruby">
#!/usr/bin/env ruby
# encoding: utf-8
# example03.rb

class String
  def to_a
    Array.new.tap do |array|
      self.chars { |ch| array &lt;&lt; ch }
    end
  end
end

p "Alice".to_a
</pre>

<pre class="brush: plain">
["A", "l", "i", "c", "e"]
</pre>

これは、文字列を1文字ずつ配列にしたものを返す`String#to_a`というメソッドを`String`クラスのインスタンスに付け加える例だ。  
もし`Object#tap`を使わなかったら、このような感じで書くハメになるだろう。

<pre class="brush: ruby">
#!/usr/bin/env ruby
# encoding: utf-8
# example04.rb

class String
  def to_a
    array = []
    self.chars { |ch| array &lt;&lt; ch }
    array
  end
end

p "Alice".to_a
</pre>

うーん、なかなか香ばしい。  

ちなみに、RailsでFactoryGirlを使ってseedを用意するときにも役に立つ。  
以下の例では、Girlというモデル（一）と、Perfume、Rouge、Manicureというモデル（多）に一対多のリレーションがあると仮定している。

<pre class="brush: ruby">
#!/usr/bin/env ruby
# encoding: utf-8
# example05.rb

3.times do
  FactoryGirl.create(:girl).tap do |girl|
    FactoryGirl.create(:perfume, user_id: girl.id)
    FactoryGirl.create(:rouge, user_id: girl.id)
    FactoryGirl.create(:manicure, user_id: girl.id)
  end
end
</pre>

Girlを生成しつつ、それに関連するPerfume、Rouge、Manicureを見通しよく生成することができる。  
seedに直接リレーションが見えるように書きたいときに`Object#tap`が大活躍する。

工夫すれば、もっといろいろな利用法が見つかると思う。  
もし面白い使い方を発見したら、ぜひ教えてほしい。