#!/bin/bash

# Uninstall launcher
xdg-desktop-menu uninstall ./src/fn-toggle.desktop
xdg-desktop-menu forceupdate

# Uninstall autostart item
rm -rf ~/.config/autostart/fn-autostart.desktop

# Uninstall policy
sudo rm /usr/share/polkit-1/actions/com.petrstepanov.linux-fn-key-toggle.policy

# Uninstall icons
xdg-icon-resource uninstall fn-f
xdg-icon-resource uninstall fn-special
gtk-update-icon-cache
