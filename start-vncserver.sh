#!/bin/bash

echo "starting VNC server ..."
export USER=root
#xtigervncserver :1 -geometry 1280x800 -depth 24 && tail -F /root/.vnc/*.log
#Xvnc :1 -geometry 1280x800 -depth 24 && tail -F /root/.vnc/*.log

sudo Xtigervnc :1 -PasswordFile=/root/.vnc/passwd -geometry 1280x800 -depth 24 &

sleep 2
export DISPLAY=:1
/usr/bin/startlxde
