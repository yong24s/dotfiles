
# Update everything first
sudo pacman -Syu --noconfirm

# Generate keys
ssh-keygen -t ecdsa -b 521 -q -N "" -f ~/.ssh/id_ecdsa

# Setup NTP
sudo pacman -S ntp
sudo timedatectl set-ntp true

# Disable BT
sudo rfkill block bluetooth

# Install programs
sudo pacman -S polybar

# Install yay
git clone https://aur.archlinux.org/yay.git /var/tmp
cd /var/tmp
makepkg -si

# Setup NTP
sudo pacman -S ntp
sudo timedatectl set-ntp true

# Disable BT
sudo rfkill block bluetooth

# Install AUR packages
yay -S google-chrome
yay -S ttf-material-design-icons-webfont

# Uninstall default programs that came with Manjaro i3
sudo pacman -R palemoon-bin

# List unused orphans packages
pacman -Qdtm

