#!/bin/bash
FNMODE=`cat /sys/module/hid_apple/parameters/fnmode`
echo Current FNMODE is $FNMODE

# Depending on the curent value of the 
echo -n "Setting FNMODE to "
if [ $FNMODE = 0 ] || [ $FNMODE = 2 ]; then
    echo 1 | pkexec tee /sys/module/hid_apple/parameters/fnmode
    sed -i 's/FN Unlock/FN Lock/' $HOME/.local/share/applications/fn-toggle.desktop
    sed -i 's/fn-unlock/fn-lock/' $HOME/.local/share/applications/fn-toggle.desktop
else
    echo 2 | pkexec tee /sys/module/hid_apple/parameters/fnmode
    sed -i 's/FN Lock/FN Unlock/' $HOME/.local/share/applications/fn-toggle.desktop
    sed -i 's/fn-lock/fn-unlock/' $HOME/.local/share/applications/fn-toggle.desktop
fi

# Update application menu list
xdg-desktop-menu forceupdate
