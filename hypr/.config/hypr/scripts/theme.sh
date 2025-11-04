#!/bin/bash
if pgrep -x rofi >/dev/null; then
    pkill -x rofi
    exit 0
fi
STOW_THEMES_DIR="$HOME/dotfiles/themes/.config/themes"
CURRENT_THEME_DIR="$STOW_THEMES_DIR/currentTheme"

mapfile -t themes < <(
  find "$STOW_THEMES_DIR" -mindepth 1 -maxdepth 1 -type d ! -name "currentTheme" -exec basename {} \; | sort
)

selection=$(printf '%s\n' "${themes[@]}" | rofi -dmenu -p "Select Theme" -i -no-custom -theme-str 'window {width: 10%;}')
if ! printf '%s\n' "${themes[@]}" | grep -qxF "$selection"; then
  exit 0
fi

rm -rf "$CURRENT_THEME_DIR"

ln -sfn "$STOW_THEMES_DIR/$selection" "$CURRENT_THEME_DIR"

hyprctl reload
systemctl --user reload --now waybar

waypaper --random

kitten themes --reload-in=all kittytheme


