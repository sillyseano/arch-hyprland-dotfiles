#!/bin/bash
APP_INITIAL_TITLE="calendar.proton.me_/u/0/"
APP_URL="https://calendar.proton.me/u/0/"
WIN_ADDRESS=$(hyprctl clients -j | jq -r ".[] | select(.initialTitle == \"$APP_INITIAL_TITLE\") | .address")
if [ -n "$WIN_ADDRESS" ]; then
    hyprctl dispatch closewindow address:$WIN_ADDRESS
else
    brave --app="$APP_URL" &
fi
