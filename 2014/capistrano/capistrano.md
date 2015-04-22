**set :gatewayが使えない**

capistranoのメジャーバージョンが3になってから、多段sshのための`set :gateway`が使えなくなってしまった（version 3.0.1現在）。

2の頃は、以下のようにすれば踏み台の設定ができた。  
（踏み台サーバのIPアドレスを`172.16.0.1`とする）

<pre class="brush: ruby">
set :gateway, "172.16.0.1"
</pre>

**sshのconfigファイルを使う**

多段sshで目的のサーバにログインする必要がある場合、sshのconfigファイルを使うのが常套手段だ。  
`fumidai.example.com`を踏み台にして、踏み台と同じローカルネットワークに所属する`172.16.0.1`に接続する場合、`~/.ssh/config`に以下のように書く。

<pre class="brush: plain">
Host fumidai
  Hostname     fumidai.example.com
  User         alice
  
Host production
  Hostname     172.16.0.1
  User         alice
  ProxyCommand ssh fumidai nc %h %p
</pre>

すると、以下のコマンドでssh接続できるようになる。

<pre class="brush: bash">
ssh production
</pre>

capistranoで使われている`Net::SSH`は`~/.ssh/config`を見てくれるので、sshのconfigが適切に設定されていれば、`deploy.rb`に以下のように書けばよいだろう。

<pre class="brush: ruby">
server 'production', user: 'alice', roles: %w[app web db],
  ssh_options: {
    keys: [File.expand_path('~/.ssh/id_rsa')],
    forward_agent: true,
    auth_methods: %w(publickey)
  }
</pre>

多段sshでサーバにログインする場合、普通はsshのconfigを用意するのが普通なので、この方法がベターだと思う。

**capistrano 3.Xで多段ssh**

[SSH gateway support in v3 - Issue #725・capistrano/capistrano](https://github.com/capistrano/capistrano/issues/725)

上述のディスカッションによると、以下のように書けば多段sshできるとのこと。

<pre class="brush: ruby">
require 'net/ssh/proxy/command'

server '172.16.0.1', user: 'alice', roles: %w[app web db],
  ssh_options: {
    keys: [File.expand_path('~/.ssh/id_rsa')],
    forward_agent: true,
    auth_methods: %w(publickey),
    proxy: Net::SSH::Proxy::Command::new('ssh alice@fumidai.example.com -W %h:%p')
  }
</pre>

見ての通り、あまりにも醜くなるので、素直にsshのconfigを使うほうが良いと思う。

