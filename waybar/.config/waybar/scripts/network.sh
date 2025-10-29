#!/bin/bash

WINDOW_TITLE="impala-popup"

# Check if a kitty window with that title is already running
window_address=$(hyprctl clients -j | jq -r --arg title "$WINDOW_TITLE" '.[] | select(.title == $title) | .address')

if [ -n "$window_address" ]; then
    # Close the window if it's open
    hyprctl dispatch closewindow address:$window_address
else
    # Launch kitty with specific geometry and title running 'impala'
    kitty --title "$WINDOW_TITLE" \
          impala &
fi

