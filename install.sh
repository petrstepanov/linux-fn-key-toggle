#!/bin/bash

# Install the script
BIN_DIR=~/.local/bin
mkdir -p $BIN_DIR
cp ./src/fn-toggle.sh $BIN_DIR
chmod +x $BIN_DIR/fn-toggle.sh
cp ./src/fn-update-icon.sh $BIN_DIR
chmod +x $BIN_DIR/fn-update-icon.sh

# Install the icons
xdg-icon-resource install --novendor --context apps --size 512 ./src/fn-f.png fn-f
xdg-icon-resource install --novendor --context apps --size 512 ./src/fn-special.png fn-special
gtk-update-icon-cache

# Install launcher
xdg-desktop-menu install ./src/fn-toggle.desktop

# Install autostart lancher
cp ./src/fn-autostart.desktop ~/.config/autostart/

# Update application menu list
fn-update-icon.sh
