#!/bin/bash

# Toggle basic rofi launcher

# If rofi is already running, kill it
if pgrep -x rofi >/dev/null; then
    pkill -x rofi
    exit 0
fi

# Otherwise open rofi
rofi -show drun

