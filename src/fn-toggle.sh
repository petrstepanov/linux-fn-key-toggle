#!/bin/bash
FNMODE=`cat /sys/module/hid_apple/parameters/fnmode`
echo Current FNMODE is $FNMODE

# Change curent value of the `fnmode`
SHORTCUT=~/.local/share/applications/fn-toggle.desktop

echo -n "Setting FNMODE to "
if [ $FNMODE = 2 ] || [ $FNMODE = 0 ]; then
    # Currently `F#` keys are on (or `fn` key is disabled same behavior)
    # Therefore, enable "special" keys
    echo 1 | pkexec tee /sys/module/hid_apple/parameters/fnmode
    # Delete line containing "Icon=" in `fn-toggle.desktop`
    sed -i "/Icon=/d" $SHORTCUT
    # Add line with new icon
    echo "Icon=fn-special" >> $SHORTCUT
else
    # Currently "special" keys are on
    # Therefore, disable "special" keys
    echo 2 | pkexec tee /sys/module/hid_apple/parameters/fnmode
    # Delete line containing "Icon=" in `fn-toggle.desktop`
    sed -i "/Icon=/d" $SHORTCUT
    # Add line with new icon
    echo "Icon=fn-f" >> $SHORTCUT
fi

# Update application menu list
xdg-desktop-menu forceupdate
