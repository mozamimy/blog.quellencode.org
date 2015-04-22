（画像をここに）

**Ariete 0.3.0 リリース**

標準出力や標準エラー出力をキャプチャする gem、[Ariete](https://github.com/mozamimy/ariete) をアップデートしました。  
0.3.0 では、以下の変更が行われています。

- RSpec 対応
- `module_function` による、モジュール経由での呼び出し

これを機に、RSpec で Ariete を使う例を README.md に記載しました。  
こんな感じでカジュアルに標準出力や標準エラー出力をキャプチャしてテストできます。

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
  include Ariete

  # You can use without 'Ariete.' if you include Ariete.
  describe ".output_out" do
    subject { capture_stdout { Klass.output_out } }
    it { expect(subject).to eq "Ariete is a kind of rabbit.\n" }
  end

  describe ".output_err" do
    subject { capture_stderr { Klass.output_err } }
    it { expect(subject).to eq "Ariete means 'Lop' in Italian.\n" }
  end

  # Also you can use as 'Ariete.capture_xxx'
  describe ".output_out" do
    subject { Ariete.capture_stdout { Klass.output_out } }
    it { expect(subject).to eq "Ariete is a kind of rabbit.\n" }
  end

  describe ".output_err" do
    subject { Ariete.capture_stderr { Klass.output_err } }
    it { expect(subject).to eq "Ariete means 'Lop' in Italian.\n" }
  end
end
</pre>

実はまだ追加したい機能があって、RSpecを拡張してカスタムマッチャーとしてArieteを使えるようにしたいなーと思っています。  
イメージとしてはこんな感じ。

<pre class="brush: ruby">
it { expect("usausa").to be_put_out }
</pre>

インストール方法などは、以下の GitHub のリポジトリを参照してください。  
https://github.com/mozamimy/ariete

ちなみに余談ですが..

Rails を使った開発では、デファクトスタンダードな RSpec ですが、[Rubyのテスティングフレームワークの歴史（2014年版）](http://www.clear-code.com/blog/2014/11/6.html)によると、これから徐々に minitest や test-unit に移行する流れが来るのかもしれません。  
私自身、RSpec 3 でのドラスティックな変更に、少し戸惑いを隠せないところがあります。

まだしばらくは RSpec が強い時期が続きそうなので、RSpec で使うことを念頭に改良していこうと思っています。  
（とはいえ、基本機能は minitest や test-unit でも使えますよ！）