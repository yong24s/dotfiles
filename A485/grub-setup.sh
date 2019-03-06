# Add idle=nomwait
echo "GRUB_CMDLINE_LINUX_DEFAULT=\"quiet idle=nomwait\"" | sudo tee -a /etc/default/grub
sudo grub-mkconfig -o /boot/grub/grub.cfg

