#!/bin/bash

clipse_window=$(hyprctl clients -j | jq -r '.[] | select(.class == "clipse") | .address')

if [[ -n "$clipse_window" ]]; then
  hyprctl dispatch closewindow address:$clipse_window
else
  kitty --class clipse -e clipse &
fi

