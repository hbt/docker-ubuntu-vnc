#!/bin/bash

cdir="$(dirname "$(readlink -f "$0")")"
passwd=$cdir/../passwd

xvnc4viewer -passwd $passwd localhost:5901

