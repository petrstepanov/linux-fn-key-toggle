#!/bin/bash

FNMODE=`cat /sys/module/hid_apple/parameters/fnmode`
echo Current FNMODE is $FNMODE

# Reflect the icon Depending on the curent value of the FNMODE 
echo -n "Setting FNMODE to "
if [ $FNMODE = 0 ] || [ $FNMODE = 2 ]; then
    sed -i 's/NoDisplay=false/NoDisplay=true/' ~/.local/share/applications/fn-lock.desktop
    sed -i 's/NoDisplay=true/NoDisplay=false/' ~/.local/share/applications/fn-unlock.desktop
else
    sed -i 's/NoDisplay=true/NoDisplay=false/' ~/.local/share/applications/fn-lock.desktop
    sed -i 's/NoDisplay=false/NoDisplay=true/' ~/.local/share/applications/fn-unlock.desktop
fi

# Update application menu list
xdg-desktop-menu forceupdate
