#!/bin/bash

cdir="$(dirname "$(readlink -f "$0")")"
passwd=$cdir/../passwd

#xvnc4viewer -passwd $passwd localhost:5901 &
#vncviewer -passwd $passwd localhost:5901 &
xtigervncviewer -passwd $passwd localhost:5901 

