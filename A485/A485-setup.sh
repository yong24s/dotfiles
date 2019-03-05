
# Disable bell
echo "blacklist pcspkr" | sudo tee /etc/modprobe.d/nobeep.conf

# Setup polybar
mkdir -p $HOME/.config/polybar/

# Setup NTP
sudo pacman -S ntp
sudo timedatectl set-ntp true


install_pulse


echo "defaults.pcm.card 1" >> /etc/asound.conf
defaults.ctl.card 1

# Disable BT
sudo rfkill block bluetooth


