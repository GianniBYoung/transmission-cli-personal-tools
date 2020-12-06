#!/bin/bash
counter=3
while IFS= read -r line
do
    #first pass will obtain torrentId
    #second pass will relocate torrent to given directory
    if [ $(($counter % 2)) -eq 1 ]; then
        torrentId=$(echo $line)
    else
        echo $line
        echo  "1( comic      2( book    3(audio book" 
        #allows us to take input from the keyboard, /dev/tty is required because of how the while loop is constructed
        read response < /dev/tty

        case "$response" in
            1) transmission-remote -t$torrentId --move /media/unit/books/mam-comics
                echo ''
                ;;
            2) transmission-remote -t$torrentId --move /media/unit/books/mam-books
                echo ''
                ;;
            3) transmission-remote -t$torrentId --move /media/unit/books/audio-books
                echo ''
                ;;
            *) echo "Not moving anywhere"
                ;;
        esac
    fi

    ((counter++))

done < ./logs/finished-torrent-info.txt
#clears log for next use.
echo "" > ./logs/finished-torrent-info.txt
