#!/bin/bash

killall xvnc4viewer
docker-compose down -t 0

docker-compose up -d 
sleep 2

cdir="$(dirname "$(readlink -f "$0")")"
passwd=$cdir/../passwd

xvnc4viewer -passwd $passwd localhost:5901 &

