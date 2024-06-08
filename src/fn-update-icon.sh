#!/bin/bash
# Script updates the Application icon according to the system's FNMODE value

# Obtain FNMODE value 
FNMODE=`cat /sys/module/hid_apple/parameters/fnmode`
echo "INFO: FNMODE is ${FNMODE}"

LAUNCHER=~/.local/share/applications/fn-toggle.desktop

# Reflect the icon depending on the curent value of the FNMODE
if [ $FNMODE = 1 ]; then
    # Keys act like "media" keys
    # Delete line containing "Icon="
    sed --in-place "/Icon=/d" $LAUNCHER
    # Add line with new icon
    echo "Icon=fn-media" >> $LAUNCHER
else
    # Keys act like "function" keys
    # Delete line containing "Icon="
    sed --in-place "/Icon=/d" $LAUNCHER
    # Add line with new icon
    echo "Icon=fn-function" >> $LAUNCHER
fi

# Update application menu list
xdg-desktop-menu forceupdate

# Exit success
exit 0
