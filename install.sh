#!/bin/bash

# Install the script
BIN_DIR=~/.local/bin
mkdir -p $BIN_DIR
cp ./src/fn-toggle.sh $BIN_DIR
chmod +x $BIN_DIR/fn-toggle.sh
cp ./src/fn-update-icon.sh $BIN_DIR
chmod +x $BIN_DIR/fn-update-icon.sh

# Install the icons
xdg-icon-resource install --novendor --context apps --size 512 ./src/fn-function.png fn-function
xdg-icon-resource install --novendor --context apps --size 512 ./src/fn-media.png fn-media
xdg-icon-resource install --novendor --context apps --size 512 ./src/fn-detecting.png fn-detecting
gtk-update-icon-cache

# Install launcher
xdg-desktop-menu install ./src/fn-toggle.desktop

# Install autostart lancher
cp ./src/fn-autostart.desktop ~/.config/autostart/

# Update application menu list
fn-update-icon.sh

echo "Setting default behavior to Media keys..."

# If Fedora (grubby command exists)
FILE=/etc/fedora-release
if test -f "$FILE"; then
  sudo grubby --update-kernel=ALL --args="hid_apple.fnmode=1"
else
  sudo echo options hid_apple fnmode=1 | sudo tee -a /etc/modprobe.d/hid_apple.conf
  sudo update-initramfs -u -k all
fi
