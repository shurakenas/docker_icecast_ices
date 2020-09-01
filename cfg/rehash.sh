#!/bin/bash

chown -R icecast2.icecast /mnt/stream && chmod -R 777 /mnt/stream
find /mnt/stream/tracks/inet -type f -name \*.mp3 > /mnt/stream/playlist.txt
sleep 2
find /mnt/stream/tracks/inet2 -type f -name \*.mp3 > /mnt/stream/playlist2.txt
sleep 5
exit 0
