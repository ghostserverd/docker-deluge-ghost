#!/bin/bash

torrentid=$1
torrentname=$2
torrentpath=$3
x=1
ddport=$(grep '"daemon_port": [0-9]*' /config/core.conf | awk -F ': ' '{print $2}' | awk -F ',' '{print $1}')

while [ $x -le 100 ]
do
sleep 2

echo "Running $x times" >> /config/unregistered.log
echo "TorrentID: $torrentid" >> /config/unregistered.log
line=$(deluge-console "connect 127.0.0.1:$ddport; info" $1 | grep "Tracker status")
echo $line >> /config/unregistered.log
case "$line" in
*unregistered*|*Sent*|*End*of*file*|*Bad*Gateway*)
deluge-console "connect 127.0.0.1:$ddport; pause '$torrentid'"
sleep 2
deluge-console "connect 127.0.0.1:$ddport; resume '$torrentid'"
;;
*)
echo "Found working torrent: $torrentname $torrentpath $torrentid" >> /config/unregistered.log
exit 1;;
esac
x=$(( $x + 1 ))
done
