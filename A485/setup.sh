# Update everything first
sudo pacman -Syu # --noconfirm

# Install yay
git clone https://aur.archlinux.org/yay.git /var/tmp
cd /var/tmp
makepkg -si

# Install tlp for power management
yay -S linux-headers
yay -S acpi_call-dkms tp_smapi-dkms tlp tlp-rdw
sudo systemctl enable tlp.service
sudo systemctl enable tlp-sleep.service
sudo systemctl enable NetworkManager-dispatcher.service
sudo systemctl mask systemd-rfkill.service
sudo systemctl mask systemd-rfkill.socket
sudo cp etc-default/tlp /etc/default/tlp

# Install bluetooth
yay -S bluez bluez-utils
sudo systemctl enable bluetooth.service

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Turn on TRIM weekly for SSD
sudo systemctl enable fstrim.timer

# Generate keys
ssh-keygen -t ecdsa -b 521 -q -N "" -f ~/.ssh/id_ecdsa

# Create common directories in $HOME
yay -S xdg-user-dirs
xdg-user-dirs-update

# Set prefs
git config --global core.editor "nvim"
sudo alsactl store # Save sound level

# Fonts to ensure Chrome is displaying UTF-8 correctly
yay -S ttf-freefont ttf-liberation ttf-droid

# Install backlight
sudo pacman -S light

# Install UI stuffs
yay -S polybar feh ttf-material-design-icons-webfont rofi lxappearance arc-gtk-theme paper-icon-theme neofetch noto-fonts-emoji python-ueberzug-git
yay -S thunar thunar-archive-plugin gvfs gvfs-smb sshfs gnome-keyring tumbler raw-thumbnailer
yay -S betterlockscreen xautolock dunst
yay -S redshift
yay -S xclip

# Install useful programs
yay -S google-chrome firefox
yay -S git ranger rxvt-unicode urxvt-resize-font-git
yay -S mlocate wget cronie udiskie arandr tree
yay -S mpv cmus alsa-lib i3-scrot bc galculator

# Additional tools
yay -S xfreerdp openvpn wireguard-tools wireguard-arch wireguard-lts
yay -S libreoffice-still evince
yay -S jdk-openjdk intellij-idea-community-edition
yay -S code

yay -S bind-tools netcat nmap

# Setup betterlockscreen
betterlockscreen -u ~/Pictures/wallpaper.jpg
sudo systemctl enable betterlockscreen@$USER

# Set thunar as xdg default
xdg-mime default Thunar-folder-handler.desktop inode/directory

# Setup getty font
pacman -S terminus-font
setfont ter-218n

# VM
yay -S polkit-gnome
yay -S qemu libvirt ebtables dnsmasq bridge-utils
sudo systemctl enable libvirtd.service
sudo systemctl start libvirtd.service

# screenshot tool
yay -S flameshot

# devops tools
yay -S htop wrk docker-compose

# Automatically connect to wifi profile
# /etc/netctl/[PROFILE]
# netctl enable [PROFILE]

# List unused orphans packages
pacman -Qdtm

# List installed packages
pacman -Qqett

# List enabled services
systemctl list-unit-files --state=enabled

# List mask services
systemctl list-unit-files --state=mask

# Downgrade a pacman install
## sudo pacman -U /var/cache/pacman/pkg/..
# Downgrade a pacman install
## sudo pacman -U /var/cache/pacman/pkg/....
