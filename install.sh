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
	inetutils
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
	rofi
	satty
	sddm
	slurp
	snapper
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

#FOR DOCKER DO THE FOLLOWING MANUALLY
# This is what causes the DOCKER to hang for 5 minutes or black screen on boot
# sudo systemctl edit systemd-networkd-wait-online.service
# [SERVICE]
# ExecStart=
# ExecStart=/usr/lib/systemd/systemd-networkd-wait-online --any --timeout=30
# sudo systemctl restart systemd-networkd-wait-online.service


# FOR QEMU AND KVM
# sudo pacman -S qemu-full qemu-img libvirt virt-install virt-manager virt-viewer edk2-ovmf swtpm guestfs-tools libosinfo dnsmasq
# sudo systemctl enable libvirtd.service
# sudo systemctl start libvirtd.service
# sudo virsh net-list --all
# sudo virsh net-start default
# sudo virsh net-autostart default
