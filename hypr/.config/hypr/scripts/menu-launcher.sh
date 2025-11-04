#!/bin/bash

if pgrep -x rofi >/dev/null; then
    pkill -x rofi
    exit 0
fi

options="Install Package\nInstall AUR Package\nUninstall Package"
choice=$(echo -e "$options" | rofi -dmenu -p "Package Manager" -theme-str 'window {width: 10%;}')

case "$choice" in
    "Install Package")
        kitty --title "pkgMenu" -e ~/.config/hypr/scripts/pkg-install.sh
        ;;
    "Install AUR Package")
        kitty --title "pkgMenu" -e ~/.config/hypr/scripts/aur-pkg-install.sh
        ;;
    "Uninstall Package")
        kitty --title "pkgMenu" -e ~/.config/hypr/scripts/remove-pkg.sh
        ;;
    *)
        exit 1
        ;;
esac

