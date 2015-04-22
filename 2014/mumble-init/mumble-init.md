**openSUSE 13.1におけるmumbleサーバ**

[Mumble](http://mumble.sourceforge.net/)というボイスチャットをするためのフリーソフトウェアがある。  
[TeamSpeak](http://www.teamspeak.com/)という競合もありmumbleと人気を二分しているが、こちらはプロプライエタリなのであまりイケてない。

さくらのVPSで動かしているサーバのOSをopenSUSE 13.1に上げたときに、なぜかmumbleの起動スクリプトが無くなってしまった。  
[mumbleの本家リポジトリ](https://github.com/mumble-voip/mumble)にあるスクリプトはopenSUSE 13.1で動かないので、このリポジトリをフォークしてスクリプトを作った。  
以下からダウンロードできる。

[mumble/scripts/murmur.init.opensuse at master・mozamimy/mumble](https://github.com/mozamimy/mumble/blob/master/scripts/murmur.init.opensuse)

<pre class="brush: bash">
#! /bin/sh
#
# Mumble server init script
# Copyright (C) 2004 Moza USANE / quellencode.org
# mozamimy@quellencode.org
#
# When you use this script, do following instructions.
#
# 1. Make the directory named /var/run/mumble-server to store PID file.
# $ sudo mkdir /var/run/mumble-server
#
# 2. Change the owner of the directory to mumble-server:mumble-server
# $ sudo chown mumble-server:mumble-server /var/run/mumble-server
#
# 3. Enable pid configration in mumble-server.ini
# $ sudo vi /etc/mumble-server.ini
# And add "pidfile=/var/run/mumble-server/mumble-server.pid"
#
#
### BEGIN INIT INFO
# Provides: murmurd
# Required-Start: $network $local_fs $remote_fs dbus
# Required-Stop:        $network $local_fs $remote_fs dbus
# Should-Start:                $mysql
# Should-Stop:                $mysql
# Default-Start: 2 3 4 5
# Default-Stop: 0 1 6
# Short-Description: Mumble VoIP Server
### END INIT INFO

INIFILE=/etc/mumble-server.ini
MURMURD_BIN=/usr/bin/murmurd
MURMURD_PID=/var/run/mumble-server/mumble-server.pid
NAME=murmurd

. /etc/rc.status
rc_reset

case "$1" in
  start)
    /sbin/startproc -p $MURMURD_PID $MURMURD_BIN -ini $INIFILE
    rc_status -v
    ;;
  stop)
    /sbin/killproc -p $MURMURD_PID -TERM $MURMURD_BIN
    rc_status -v
    ;;
  status)
    /sbin/checkproc -p $MURMURD_PID $MURMURD_BIN
    rc_status -v
    ;;
  restart)
    $0 stop
    $0 start
    rc_status
    ;;
  *)
    N=/etc/init.d/$NAME
    echo "Usage: $N {start|stop|status|restart}" >&2
    exit 3
    ;;
esac

exit 0
</pre>

以上のスクリプトを`/etc/init.d/murmurd`に配置し、

<pre class="brush: bash">
sudo chmod +x /etc/init.d/murmurd
sudo chkconfig murmurd on
</pre>

でOS起動時にmumbleのサーバも自動で起動するようになる。

