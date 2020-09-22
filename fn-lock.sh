#!/bin/bash

# Lock the FN key
echo 2 | pkexec tee /sys/module/hid_apple/parameters/fnmode

# Hide "Lock" launcher, display "Unock" launcher
sed -i 's/NoDisplay=false/NoDisplay=true/' ~/.local/share/applications/fn-lock.desktop
sed -i 's/NoDisplay=true/NoDisplay=false/' ~/.local/share/applications/fn-unlock.desktop

# Update application menu list
xdg-desktop-menu forceupdate
