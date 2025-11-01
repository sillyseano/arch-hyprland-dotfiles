#!/bin/bash
WINDOW_TITLE="bluetui-popup"
# Get the window address based on the title
window_address=$(hyprctl clients -j | jq -r --arg title "$WINDOW_TITLE" '.[] | select(.title == $title) | .address')

if [ -n "$window_address" ]; then
    hyprctl dispatch closewindow address:$window_address
else
    kitty --title "$WINDOW_TITLE" bluetui &
fi

