#!/bin/bash
counter=1

numberofTorrents=$(transmission-remote -l|tail -2 |head -1 |awk '{print $1}')

for i in $(seq 1 $numberofTorrents)
do
    #obtains ID and Location of torrent
    output=$(echo $(transmission-remote -t$counter -i| grep '\<Id\>\|Location'))

    #isolates path
    currentPath=$(echo $output|awk '{print $4}')

    if [ $currentPath == "/media/unit/completed" ]; then
        #prints ID of torrents in 'completed' directory to file
        echo $output|awk '{print$2}' >> ./logs/torrentlist.txt
    fi
    
    ((counter++))
done
