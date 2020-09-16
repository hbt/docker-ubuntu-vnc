#!/bin/bash

killall xtigervncviewer
killall xvnc4viewer
docker-compose down -t 0
docker-compose build

docker-compose up -d 
sleep 2

cdir="$(dirname "$(readlink -f "$0")")"
$cdir/connect-vnc.sh

#passwd=$cdir/../passwd
#xvnc4viewer -passwd $passwd localhost:5901 &

