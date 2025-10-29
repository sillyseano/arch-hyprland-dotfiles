#!/bin/bash
SAVE_DIR="$HOME/Screenshots"
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
FILENAME="$SAVE_DIR/screenshot_$TIMESTAMP.png"
mkdir -p "$SAVE_DIR"
grim -g "$(slurp)" - |
	satty --filename - \
    		--output-filename "$SAVE_DIR/screenshot-$(date +'%Y-%m-%d_%H-%M-%S').png" \
    		--early-exit \
    		--actions-on-enter save-to-clipboard \
    		--save-after-copy \
    		--copy-command 'wl-copy'

