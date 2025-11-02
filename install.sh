PACMAN_PKGS=(
	bluetui
	bluez
	bluez-utils
	btop
	discord
	dunst
	fastfetch
	fuse2
	fzf
	git
	grim
	hyprpolkitagent
	impala
	jq
	kitty
	lazygit
	man-db
	mpv
	nautilus
	neovim
	networkmanager
	nftables
	noto-fonts
	noto-fonts-cjk
	noto-fonts-emoji
	noto-fonts-extra
	openssh
	proton-vpn-gtk-app
	rofi
	satty
	sddm
	slurp
	snapper
	steam
	stow
	swww
	ttf-nerd-fonts-symbols
	vim
	waybar
	wget
	wiremix
	wl-clipboard
	xdg-desktop-portal-hyprland
	yay
)

YAY_PKGS=(
	brave-bin
	clipse
	waypaper
	spotify
	signal-desktop
)

UNINSTALL=(
	dolphin
	htop
	nano
	wofi
)

echo "==> Updating system..."
sudo pacman -Syu --noconfirm

echo "==> Installing Pacman PKGS..."
for pkg in "${PACMAN_PKGS[@]}"; do
  sudo pacman -S --noconfirm --needed "$pkg"
done

echo "==> Installing YAY PKGS..."
for pkg in "${YAY_PKGS[@]}"; do
  yay -S --noconfirm --needed "$pkg"
done

echo "==> Uninstalling unused packages..."
for pkg in "${UNINSTALL[@]}"; do
  sudo pacman -Rns --noconfirm "$pkg"
done

sudo systemctl enable --now NetworkManager
sudo systemctl enable --now bluetooth
systemctl --user enable --now hyprpolkitagent.service
