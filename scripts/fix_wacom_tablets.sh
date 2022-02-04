#!/usr/bin/env bash
# Script for rebinding Wacom tablets/styluses to operate on a specific
# monitor in a multimonitor setup. Pass in the name of a display
# device as the first argument; otherwise the first connected display
# device will be used.
#
# Requires xsetwacom and xrandr.
# (On Arch Linux: install `xf86-input-wacom` and restart the X server.)

set -euo pipefail
IFS=$'\n\t'

readarray -t devices < <(xrandr | sed -nr 's/(^[a-zA-Z0-9_\-]+) connected.*$/\1/p')
readarray -t pens < <(xsetwacom --list devices | sed -nr 's/^([a-zA-Z0-9_ \-]+) +.*$/\1/p')

if [[ "$#" -ge 1 ]]; then
    display="$1"
else
    # Modify this variable to hardcode the display you want to bind
    # the tablet to. If this variable is empty, the first display
    # returned by `xrandr | grep " connected"` will be used.
    display=""
fi

if [[ -z $display ]]; then
    display=${devices[0]}
else
    # Using an associative array would be more idiomatic, but
    # associative arrays in Bash suuuuck and I'm assuming there aren't
    # that many connected devices anyways.
    exists=0
    for device in "${devices[@]}"; do
        if [[ $device == "$display" ]]; then
            exists=1
            break
        fi
    done

    if [[ $exists == 0 ]]; then
        echo "Specified display device \"$display\" does not exist; available options are:"
        printf ' - %s\n' "${devices[@]}"
        exit 1
    fi
fi

for pen in "${pens[@]}"; do
    xsetwacom set "$pen" MapToOutput "$display"
    echo "Bound \"$pen\" to \"$display\""
done
