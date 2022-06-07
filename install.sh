#!/bin/bash

# Install the script
BIN_DIR=~/.local/bin
mkdir -p $BIN_DIR
cp ./src/fn-toggle.sh $BIN_DIR
chmod +x $BIN_DIR/fn-toggle.sh
cp ./src/fn-autostart.sh $BIN_DIR
chmod +x $BIN_DIR/fn-autostart.sh

# Install the icons
xdg-icon-resource install --novendor --context apps --size 512 ./src/fn-f.png fn-f
xdg-icon-resource install --novendor --context apps --size 512 ./src/fn-special.png fn-special
gtk-update-icon-cache

FNMODE=`cat /sys/module/hid_apple/parameters/fnmode`
echo Current FNMODE is $FNMODE
# Reflect current FN Mode
if [ $FNMODE = 2 ] || [ $FNMODE = 0 ]; then
    # Currently `F#` keys are on (or `fn` key is disabled same behavior)
    sed -i "/Icon=/d" ./src/fn-toggle.desktop
    echo "Icon=fn-f" >> ./src/fn-toggle.desktop
else
    # Currently "special" keys are on
    sed -i "/Icon=/d" ./src/fn-toggle.desktop    
    echo "Icon=fn-special" >> ./src/fn-toggle.desktop
fi

# Install launcher
xdg-desktop-menu install ./src/fn-toggle.desktop

# Install autostart lancher
cp ./src/fn-autostart.desktop ~/.config/autostart/

# Update application menu list
xdg-desktop-menu forceupdate
