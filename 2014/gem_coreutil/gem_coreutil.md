**gemのインストールに失敗する**

新しいプロジェクトに参加することになり、いつものごとく`bundle install`したら、native extensionのビルドに失敗。  
ハマったのでメモ。

**環境**

- OS X 10.9.1 (Mavericks)
- homebrewでcoreutilsをインストール済み

**事象**

`bundle install`したら、atomicというgemのビルドに失敗する。

<pre class="brush: plain">
Gem::Ext::BuildError: ERROR: Failed to build gem native extension.

    /Users/flost/.rvm/rubies/ruby-2.0.0-p0/bin/ruby extconf.rb 
creating Makefile

make "DESTDIR=" clean

make "DESTDIR="
compiling atomic_reference.c
atomic_reference.c:50:9: warning: implicit declaration of function 'OSAtomicCompareAndSwap64' is invalid in C99 [-Wimplicit-function-declaration]
    if (OSAtomicCompareAndSwap64(expect_value, new_value, &DATA_PTR(self))) {
        ^
1 warning generated.
linking shared-object atomic_reference.bundle

make "DESTDIR=" install
make: /opt/local/bin/gmkdir: No such file or directory
make: *** [.RUBYARCHDIR.time] Error 1

make install failed, exit code 2

Gem files will remain installed in /Users/flost/work/banana/vendor/bundler/ruby/2.0.0/gems/atomic-1.1.10 for inspection.
Results logged to /Users/flost/work/banana/vendor/bundler/ruby/2.0.0/extensions/x86_64-darwin-12/2.0.0/atomic-1.1.10/gem_make.out

An error occurred while installing atomic (1.1.10), and Bundler cannot continue.
Make sure that `gem install atomic -v '1.1.10'` succeeds before bundling. 
</pre>    

どうやら、`/opt/local/bin/gmkdir`なんて無いよ！ということらしい。  
（warningが出ているのもいささか気持ち悪いが、ひとまず見なかったことにしよう）

**解決策**

homebrewでインストールしたcoreutilsに含まれる`gmkdir`へのシンボリックリンクを、`/opt/local/bin/gmkdir`に張る。  

*gmkdirの所在を確認*

<pre class="brush: bash">
which gmkdir
</pre>

<pre class="brush: plain">
/usr/local/bin/gmkdir
</pre>

homebrewでインストールしたオブジェクトの実体はCellerの下に配置されるが、`/usr/local/bin`下にシンボリックリンクが張られる。

*シンボリックリンクを張る*

`/usr/local/bin`ディレクトリが無ければ、作る。

<pre class="brush: bash">
sudo mkdir -p /opt/local/bin
</pre>

リンクを張る。  
同様に`ginstall`も必要となるので同時にリンクを張る。

<pre class="brush: bash">
sudo ln -s /usr/local/bin/gmkdir /opt/local/bin/gmkdir
sudo ln -s /usr/local/bin/ginstall /opt/local/bin/ginstall
</pre>

これでatomicのビルドとインストールが通るはず。

**まとめ**

`gmkdir`は、要するにGNU coreutilsに含まれている`mkdir`である。  
OS Xのデフォルトだと入っていないと思われるので、なぜわざわざ`gmkdir`を使いにいこうとするのかは、よくわからない。

もしcoreutilsをインストールしていなければ、元々OS Xに入っている`mkdir`や`install`にリンクしても良いかもしれない。





