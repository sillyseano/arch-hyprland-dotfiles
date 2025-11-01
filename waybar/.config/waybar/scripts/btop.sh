#!/bin/bash
WINDOW_TITLE="btop"
# Find the window by title
window_address=$(hyprctl clients -j | jq -r --arg title "$WINDOW_TITLE" '.[] | select(.title == $title) | .address')

if [ -n "$window_address" ]; then
    hyprctl dispatch closewindow address:$window_address
else
    kitty --title "$WINDOW_TITLE" btop &
fi

