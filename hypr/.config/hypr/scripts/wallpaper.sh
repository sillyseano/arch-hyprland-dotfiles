#!/bin/bash
# Rofi Wallpaper Picker
# Wallpapers directory
WALL_DIR="$HOME/dotfiles/themes/.config/themes/currentTheme/wallpapers"
CACHE_DIR="$HOME/.cache/rofi_wallpapers"

# Rofi theme and monitor info
ROFI_THEME="$HOME/dotfiles/rofi/.config/rofi/wallpapers.rasi"
FOCUSED_MONITOR=$(hyprctl monitors -j | jq -r '.[] | select(.focused) | .name')

if [[ -z "$FOCUSED_MONITOR" ]]; then
  notify-send "Error" "Could not detect focused monitor"
  exit 1
fi

SCALE_FACTOR=$(hyprctl monitors -j | jq -r --arg mon "$FOCUSED_MONITOR" '.[] | select(.name == $mon) | .scale')
MONITOR_HEIGHT=$(hyprctl monitors -j | jq -r --arg mon "$FOCUSED_MONITOR" '.[] | select(.name == $mon) | .height')

ICON_SIZE=$(echo "scale=1; ($MONITOR_HEIGHT * 3) / ($SCALE_FACTOR * 150)" | bc)
ICON_SIZE=$(awk -v val="$ICON_SIZE" 'BEGIN{if(val<15) val=20; if(val>25) val=25; print val}')
ROFI_OVERRIDE="element-icon{size:${ICON_SIZE}%;}"

# Ensure cache dirs exist
mkdir -p "$CACHE_DIR/gif" "$CACHE_DIR/video"

# Generate Rofi menu
menu() {
  local pics
  mapfile -d '' pics < <(find "$WALL_DIR" -type f \( \
    -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" -o \
    -iname "*.bmp" -o -iname "*.tiff" -o -iname "*.webp" -o \
    -iname "*.mp4" -o -iname "*.mkv" -o -iname "*.mov" -o -iname "*.webm" \) -print0)

  # Random option
  for pic in "${pics[@]}"; do
    local name=$(basename "$pic")
    local icon="$pic"

    if [[ "$name" =~ \.gif$ ]]; then
      icon="$CACHE_DIR/gif/$name.png"
      [[ ! -f "$icon" ]] && magick "$pic[0]" -resize 1920x1080 "$icon"
    elif [[ "$name" =~ \.(mp4|mkv|mov|webm)$ ]]; then
      icon="$CACHE_DIR/video/$name.png"
      [[ ! -f "$icon" ]] && ffmpeg -v error -y -i "$pic" -ss 00:00:01.000 -vframes 1 "$icon"
    fi

    printf "%s\x00icon\x1f%s\n" "$(basename "$pic" | cut -d. -f1)" "$icon"
  done
}

# Apply wallpaper
apply_wallpaper() {
  local file="$1"
  if [[ "$file" =~ \.(mp4|mkv|mov|webm)$ ]]; then
    kill_wallpapers
    mpvpaper '*' -o "load-scripts=no no-audio --loop" "$file" &
  else
    kill_wallpapers
    swww-daemon --format xrgb >/dev/null 2>&1 &
    sleep 0.5
    swww img -o "$FOCUSED_MONITOR" "$file" --transition-type any --transition-duration 2 --transition-fps 60
  fi
}

# Main
CHOICE=$(menu | rofi -i -show -dmenu -config "$ROFI_THEME" -theme-str "$ROFI_OVERRIDE")
CHOICE=$(echo "$CHOICE" | xargs)

if [[ "$CHOICE" == ". Random" ]]; then
  CHOICE=$(find "$WALL_DIR" -type f | shuf -n 1)
else
  CHOICE=$(find "$WALL_DIR" -iname "$CHOICE.*" -print -quit)
fi

[[ -z "$CHOICE" ]] && exit 0
apply_wallpaper "$CHOICE"

