#!/bin/bash

FNMODE=`cat /sys/module/hid_apple/parameters/fnmode`
echo Current FNMODE is $FNMODE

SHORTCUT=~/.local/share/applications/fn-toggle.desktop

# Reflect the icon depending on the curent value of the FNMODE
if [ $FNMODE = 1 ]; then
    # Keys act like "special" keys
    # Delete line containing "Icon="
    sed -i "/Icon=/d" $SHORTCUT
    # Add line with new icon
    echo "Icon=fn-special" >> $SHORTCUT
else
    # Keys act like "F#"
    # Delete line containing "Icon="
    sed -i "/Icon=/d" $SHORTCUT
    # Add line with new icon
    echo "Icon=fn-f" >> $SHORTCUT
fi

# Update application menu list
xdg-desktop-menu forceupdate
