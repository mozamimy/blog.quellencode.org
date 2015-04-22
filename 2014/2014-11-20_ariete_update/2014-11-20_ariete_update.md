![](https://31.media.tumblr.com/fb0e32c88368787525053bc84fe59941/tumblr_inline_nf6bxo5onj1qhwl24.png)

**Ariete 1.0.0 リリース**

標準出力や標準エラー出力をキャプチャする gem、[Ariete](https://github.com/mozamimy/ariete) をアップデートしました。  
1.0.0 では、以下の変更が行われています。

- RSpec のカスタム<strike>抹茶🍵</strike>マッチャーに対応

こんな感じでカジュアルに出力をテストできるようになりました。  
（README.md より抜粋）

**klass.rb**

<pre class="brush: ruby">
class Klass
  class &lt;&lt; self
    def output_out
      puts "Ariete is a kind of rabbit."
    end

    def output_err
      warn "Ariete means 'Lop' in Italian."
    end
  end
end
</pre>

**klass_spec.rb**

<pre class="brush: ruby">
require "ariete"
require_relative "klass"

RSpec.describe Klass do
  describe ".output_out" do
    subject { Klass.method(:output_out).to_proc }
    it { expect(subject).to be_output "Ariete is a kind of rabbit.\n" }
  end
  
  describe ".output_out(with lambda)" do
    subject { -> { Klass.output_out } }
    it { expect(subject).to be_output "Ariete is a kind of rabbit.\n" }
  end

  describe ".output_err" do
    subject { Klass.method(:output_err).to_proc }
    it { expect(subject).to be_output_to_stderr "Ariete means 'Lop' in Italian.\n" }
  end
end
</pre>

expect に Proc オブジェクトを渡すと、Ariete が Proc オブジェクトの中身を実行し、期待値と比較してくれます。  
1 番目の example は `to_proc` を使って Proc オブジェクトを生成していますが、2 番目のようにラムダ式を使うなどしてテストすることもできます。  
この辺、どう書くかはお好みでどうぞ。

インストール方法などは、以下の GitHub のリポジトリを参照してください。  
https://github.com/mozamimy/ariete  
基本的に `$ (sudo) gem install ariete` でインストールできると思います。

実はまだもう少し改良したいところがあって、

- テストに失敗したときのエラーメッセージが残念
- minitest や test-unit に対応したい

などなど。

非常に小さい gem で、だいたい完成形に近づいてきたので、あとはちょっとずつメンテしてく感じになると思います。  
もしフィードバックいただければ対応します。