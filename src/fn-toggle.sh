#!/bin/bash
FNMODE=`cat /sys/module/hid_apple/parameters/fnmode`
echo Current FNMODE is $FNMODE

echo -n "Setting FNMODE to "
if [ $FNMODE = 1 ]; then
    # Currently "media" keys are on
    # Therefore, change to "F#" keys
    echo 2 | pkexec tee /sys/module/hid_apple/parameters/fnmode
    notify-send -i fn-function "FN Toggle" "Function keys selected"
else
    # Keys act like "F#"
    # Therefore, change to "media" keys
    echo 1 | pkexec tee /sys/module/hid_apple/parameters/fnmode
    notify-send -i fn-media "FN Toggle" "Media keys selected"    
fi

fn-update-icon.sh
