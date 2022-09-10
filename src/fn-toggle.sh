#!/bin/bash
FNMODE=`cat /sys/module/hid_apple/parameters/fnmode`
echo Current FNMODE is $FNMODE

echo -n "Setting FNMODE to "
if [ $FNMODE = 1 ]; then
    # Currently "special" keys are on
    # Therefore, change to "F#" keys
    echo 2 | pkexec tee /sys/module/hid_apple/parameters/fnmode
else
    # Keys act like "F#"
    # Therefore, change to "special" keys
    echo 1 | pkexec tee /sys/module/hid_apple/parameters/fnmode
fi

fn-update-icon.sh
