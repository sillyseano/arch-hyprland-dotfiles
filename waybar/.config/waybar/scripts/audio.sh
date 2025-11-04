#!/bin/bash
TERMINAL_TITLE="WireMixTerm"
CMD="wiremix -v output"

window_address=$(hyprctl clients -j | jq -r --arg title "$TERMINAL_TITLE" '.[] | select(.title == $title) | .address')

if [ -n "$window_address" ]; then
    hyprctl dispatch closewindow address:$window_address
else
    kitty --title "$TERMINAL_TITLE" bash -c "$CMD" &
fi

