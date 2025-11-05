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

# Define the path to your wallpapers directory
wallpaper_dir="$HOME/dotfiles/themes/.config/themes/currentTheme/wallpapers"

# Pick a random wallpaper from the folder
random_wallpaper=$(find "$wallpaper_dir" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \) | shuf -n 1)

# Check if a random wallpaper was found
if [[ -n "$random_wallpaper" ]]; then
    # Set the wallpaper using swww
    swww img "$random_wallpaper" --transition-type any --transition-duration 2 --transition-fps 60
else
    echo "No wallpaper files found in $wallpaper_dir"
fi
kitten themes --reload-in=all kittytheme


