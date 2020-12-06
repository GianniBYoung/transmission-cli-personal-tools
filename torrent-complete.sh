#!/bin/bash
notify-send " ✔  Transmission-daemon" "$TR_TORRENT_NAME has completely downloaded."
echo "$TR_TORRENT_NAME has finished downloading!"


echo $TR_TORRENT_ID >> /home/gianni/Documents/code/bash/transmission/logs/finished-torrent-info.txt
echo $TR_TORRENT_NAME >> /home/gianni/Documents/code/bash/transmission/logs/finished-torrent-info.txt

