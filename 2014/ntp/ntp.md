**nptdの脆弱性を悪用した大規模攻撃**

nptdの脆弱性に起因する大規模攻撃が流行しているようだ。  
monitor機能を無効にしているか、ntpdをpublicに公開していなければ影響を受けないとのこと。

[NTP増幅攻撃で“史上最大規模”を上回るDDoS攻撃発生 - @IT](http://www.atmarkit.co.jp/ait/articles/1402/12/news140.html)

ちなみに、openSUSE 13.1のntpdのバージョンは4.2.6p5なので、この脆弱性の影響を受ける。  
うちのサーバではmonitor機能が有効になっていたが、ファイアウォールによって適切にパケットをフィルタしているので事なきを得た。

**初心者とVPS**

Webページを巡回していると、初心者向けの「VPSを使ってサーバ管理の勉強を始めよう！」といった記事を頻繁に見かける。思うに、これは非常に危険だ。  
言うならば、銃の撃ち方を知らない一般市民が、テロリストが立て籠もっている建物に突撃するようなものだ。  
なお悪いことにVPSでは、脆弱なサーバが攻撃されると、ネットワーク的に近いサーバも危険にさらされやすい。その影響は、脆弱なサーバだけにとどまらないのである。

近年は、計算機の性能向上、QEMUやVirutalBoxなどの発展によって、仮想環境によるサンドボックスを構築することが容易になった。  
初心者はVPSを使って海原を泳ぐ前に、仮想環境という安全な小さなプールで泳ぐ練習をすべきだ。

どこからどこまでが初心者、といった線引きをするのは難しい。  
だが、少なくともLinuxコマンドのリの字も知らないぐらいの人間に、VPSを積極的に勧めるのはやめてほしいと思う今日このごろである。