# Update everything first
sudo pacman -Syu # --noconfirm

# Install yay
git clone https://aur.archlinux.org/yay.git /var/tmp
cd /var/tmp
makepkg -si

# Install backlight
sudo pacman -S light

# Install polybar and UI stuffs
yay -S polybar feh ttf-material-design-icons-webfont rofi

# Install useful programs
yay -S google-chrome
yay -S git ranger rxvt-unicode urxvt-resize-font-git

# Install TLP extras
yay -S linux-headers
yay -S acpi_call-dkms tp_smapi-dkms tlp
sudo systemctl enable tlp.service
sudo systemctl enable tlp-sleep.service
sudo systemctl mask systemd-rfkill.service
sudo systemctl mask systemd-rfkill.socket

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
wget -O $ZSH_CUSTOM/themes/common.zsh-theme https://raw.githubusercontent.com/jackharrisonsherlock/common/master/common.zsh-theme

# Set prefs
git config --global core.editor "vim"
sudo alsactl store # Save sound level

# Turn on TRIM weekly for SSD
sudo systemctl enable fstrim.timer

# Generate keys
ssh-keygen -t ecdsa -b 521 -q -N "" -f ~/.ssh/id_ecdsa

# Create common directories in $HOME
yay -S xdg-user-dirs
xdg-user-dirs-update

# Automatically connect to wifi profile
# /etc/netctl/[PROFILE]
# netctl enable [PROFILE]

# Additional tools
yay -S xfreerdp openvpn wireguard-tools mlocate wget
yay -S lxappearance arc-gtk-theme paper-icon-theme
yay -S thunar thunar-archive-plugin gvfs gvfs-smb sshfs gnome-keyring
yay -S mpv cmus i3-scrot bc galculator dunst
yay -S libreoffice-still lector-git
yay -S jdk-openjdk intellij-idea-community-edition
yay -S neofetch noto-fonts-emoji

# List unused orphans packages
pacman -Qdtm

# List installed packages
pacman -Qqett
