#!/bin/bash
counter=1

numberofTorrents=$(transmission-remote -l|tail -2 |head -1 |awk '{print $1}')

for i in $(seq 1 $numberofTorrents)
do
# concept is good but torrent number is wrong.
# it will not be counter.
   if transmission-remote -t$counter -i | fgrep -iq 'bad request'; then
        torrentId=$(echo $(transmission-remote -t$counter -i| grep '\<Id\>'))
        transmission-remote -t$counter -v
    
        echo "Fixing bad request on torrent $counter"
    fi

    ((counter++))

done
