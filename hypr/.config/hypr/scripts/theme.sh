#!/bin/bash

# ----------------------------
# Stow-based theme switcher
# ----------------------------

# Path to Stow repo
STOW_THEMES_DIR="$HOME/dotfiles/themes/.config/themes"

# Path to currentTheme symlink in stow repo
CURRENT_THEME_DIR="$STOW_THEMES_DIR/currentTheme"

# Get theme folder names (exclude currentTheme)
mapfile -t themes < <(
  find "$STOW_THEMES_DIR" -mindepth 1 -maxdepth 1 -type d ! -name "currentTheme" -exec basename {} \; | sort
)

# Let the user select a theme via rofi
selection=$(printf '%s\n' "${themes[@]}" | rofi -dmenu -p "Select Theme" -i -no-custom)

# Exit if selection is invalid
if ! printf '%s\n' "${themes[@]}" | grep -qxF "$selection"; then
  exit 0
fi

# ----------------------------
# Update currentTheme symlink
# ----------------------------

# Remove existing symlink/folder
rm -rf "$CURRENT_THEME_DIR"

# Create new symlink pointing to selected theme folder
ln -sfn "$STOW_THEMES_DIR/$selection" "$CURRENT_THEME_DIR"

# ----------------------------
# Reload apps to reflect new theme
# ----------------------------

# Restart Waybar
hyprctl reload
systemctl --user reload --now waybar

# Update wallpaper (assuming waypaper is installed)
waypaper --random

# Reload Kitty theme (kitten command)
kitten themes --reload-in=all kittytheme


