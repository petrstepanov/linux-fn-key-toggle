#!/bin/bash

# Unlock the FN key
echo 1 | pkexec tee /sys/module/hid_apple/parameters/fnmode

# Hide "Unlock" launcher, display "Lk" launcher
sed -i 's/NoDisplay=true/NoDisplay=false/' ~/.local/share/applications/fn-lock.desktop
sed -i 's/NoDisplay=false/NoDisplay=true/' ~/.local/share/applications/fn-unlock.desktop

# Update application menu list
xdg-desktop-menu forceupdate
