#!/bin/bash
# Script toggles the Function/Media keys

# Obtain current fnmode 
FNMODE=`cat /sys/module/hid_apple/parameters/fnmode`
echo "INFO: FNMODE is ${FNMODE}"

# Define variables
ICON_FOLDER=$HOME/.local/share/icons/hicolor/scalable/apps
NS_ARGS=(--icon fn-symbolic --app-name "FN Toggle" --category device)
# CONFIG_FILE="${HOME}/.config/fn-toggle/fn-toggle.conf"

# Log function
function do_log {
        local DATE=`date`
        # echo "${DATE} FNMODE is ${FNMODE} set to ${1}" > ${HOME}/.local/share/fn-toggle/log.txt
        echo "${DATE} hello $1" >> ${HOME}/.local/share/fn-toggle/log.txt
 }

# Get previous notification ID
#ID=`cat ${CONFIG_FILE}`
#echo "${ID}"

echo -n "INFO: Setting FNMODE to "
if [ $FNMODE = 1 ]; then
    # Currently "media" keys are active
    # Change behavior to "F#" keys
    echo 2 | pkexec tee /sys/module/hid_apple/parameters/fnmode
    notify-send "${NS_ARGS[@]}" --hint "string:image-path:${ICON_FOLDER}/fn-function.svg" "Function keys active"
    # Log
    do_log "2-FUNCTION"
else
    # Currently "F#" keys are active
    # Change behavior to "media" keys
    echo 1 | pkexec tee /sys/module/hid_apple/parameters/fnmode
    notify-send "${NS_ARGS[@]}" --hint "string:image-path:${ICON_FOLDER}/fn-media.svg" "Media keys active"
    # Log
    do_log "1-MEDIA"
fi

# Update App icon
fn-update-icon.sh

# Exit success
exit 0
