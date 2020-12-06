#!/bin/bash
counter=1
comicsPath="mam-comics"
booksPath="mam-books"
audiobooksPath="audio-books"
completedPath="completed"
uploadsPath="my uploads"


while IFS= read -r line
do
    # first pass obtains torrentId
    # second pass obtains current path of torrent
    if [ $(($counter%2)) -eq 1 ] ;then
        torrentId=$(echo "$line" |awk '{print $2}')
        echo "the torrentid is $torrentId\n"
        ((counter++))

    else

        torrentPath=$(echo $line | awk 'BEGIN { FS = "/" }; {print $NF}')
        echo "the path is $torrentPath"

        # tells transmission where to findsidentical path on new hard drive
        case "$torrentPath" in
            $comicsPath) transmission-remote -t$torrentId --find /media/unit/books/mam-comics
                ;;
            $booksPath) transmission-remote -t$torrentId --find /media/unit/books/mam-books
                ;;
            $audiobooksPath) transmission-remote -t$torrentId --find /media/unit/books/audio-books
                ;;
            $completedPath) transmission-remote -t$torrentId --find /media/unit/completed
                ;;
            $uploadsPath) transmission-remote -t$torrentId --find /media/unit/my-uploads
                ;;
            *) echo "Not moving anywhere"
                ;;
        esac

        ((counter++))

    fi
done < ./logs/torrents.txt
