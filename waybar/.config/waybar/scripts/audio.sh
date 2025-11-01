#!/bin/bash
TERMINAL_TITLE="WireMixTerm"
CMD="wiremix"

# Find the window by title
window_address=$(hyprctl clients -j | jq -r --arg title "$TERMINAL_TITLE" '.[] | select(.title == $title) | .address')

if [ -n "$window_address" ]; then
    # Close the window if it's open
    hyprctl dispatch closewindow address:$window_address
else
    # Launch the terminal with the desired title and command
    kitty --title "$TERMINAL_TITLE" "$CMD" &
fi

