#!/bin/bash

# Install scripts
echo "INFO: Copying scripts."
BIN_DIR=~/.local/bin
mkdir -p $BIN_DIR
cp ./src/fn-*.sh $BIN_DIR
chmod +x $BIN_DIR/fn-*.sh

# Install policy
echo "INFO: Installing policy."
sudo cp ./src/linux-fn-key-toggle.policy /usr/share/polkit-1/actions

# Install icons (old code for PNG)
# xdg-icon-resource install --novendor --context apps --size 512 ./src/fn-function.png fn-function
# xdg-icon-resource install --novendor --context apps --size 512 ./src/fn-media.png fn-media
# xdg-icon-resource install --novendor --context apps --size 512 ./src/fn-detecting.png fn-detecting
# gtk-update-icon-cache

# Install icons (SVG)
echo "INFO: Installing icons."
ICON_FOLDER=$HOME/.local/share/icons/hicolor/scalable/apps
SYMBOLIC_ICON_FOLDER=$HOME/.local/share/icons/hicolor/symbolic/apps
# - Application icons (dynamic)
mkdir -p $ICON_FOLDER
cp ./resources/fn-function.svg $ICON_FOLDER
cp ./resources/fn-detecting.svg $ICON_FOLDER
cp ./resources/fn-media.svg $ICON_FOLDER
xdg-desktop-menu forceupdate
# - Symbolic icon
mkdir -p $SYMBOLIC_ICON_FOLDER
cp ./resources/fn-symbolic.svg $SYMBOLIC_ICON_FOLDER
gtk-update-icon-cache --ignore-theme-index $HOME/.local/share/icons/hicolor/

# Install launcher and autostart entry
echo "INFO: Adding app launcher."
xdg-desktop-menu install ./src/fn-toggle.desktop
echo "INFO: Creating autostart entry."
cp ./src/fn-autostart.desktop ~/.config/autostart/

# Update application menu list
fn-update-icon.sh

# Create app folder
mkdir -p ${HOME}/.local/share/fn-toggle

# If Fedora (grubby command exists)
echo "INFO: Setting default behavior for Media keys."
FILE=/etc/fedora-release
if test -f "$FILE"; then
  sudo grubby --update-kernel=ALL --args="hid_apple.fnmode=1"
else
  sudo echo options hid_apple fnmode=1 | sudo tee -a /etc/modprobe.d/hid_apple.conf
  sudo update-initramfs -u -k all
fi

# Exit success
exit 0
