## Arch Linux Installation guide for ThinkPad A485

> This guide extends [Arch Linux Wiki's Installation guide](https://wiki.archlinux.org/index.php/Installation_guide) to include topics like EFI, Account Creation and Xorg. <br/>
> The guide assumes that you are installing `Arch Linux` on an `UEFI` system with on a single drive.

### Partition the drive
1. Run `fdisk -l` to find the drive for installation `i.e.` */dev/sda*
2. Use `fdisk` or `cfdisk` to create two primary paritions
```
fdisk /dev/sda
```
> Partition 1: +512M type (1): efi system <br/>
Partition 2: Remaining GiB type (24): linux root (x86-64)

3. Verify that the paritions are created correctly with `v` and the `disk label type` is `GPT` with `fdisk -l`
4. Format the partitions with `mkfs`
```
mkfs.fat -F32 /dev/sda1
mkfs.ext4 /dev/sda2
```
5. Mount the partition
```
mount /dev/sda2 /mnt
mkdir /mnt/efi
mount /dev/sda1 /mnt/efi
```

### Install Core Packages
1. To connect to wifi, run `wifi-menu`
1. `pacstrap /mnt base base-devel vim dialog wpa_supplicant`
1. `genfstab -U /mnt >> /mnt/etc/fstab`

### Set system settings
`arch-chroot /mnt`

#### Set time

```
unlink /etc/localtime
ln -s /usr/share/zoneinfo/Singapore /etc/localtime
timedatectl set-ntp true
```
#### Set locale
```
vim /etc/locale.gen
locale-gen
```
> Remove # to before a locale to use it

#### Set hostname
```
echo A485 > /etc/hostname
```

#### Change root password
```
passwd
```

#### Add a user
```
useradd -m -g users -s /bin/bash [USER]
passwd [USER]
```
#### Add user to sudoers
```
visudo
Insert [USER] ALL=(ALL) ALL
```

### Add kernel options
```
pacman -S grub
vim /etc/grub.d/grub
Change GRUB_CMDLINE_LINUX_DEFAULT = "quiet idle=nomwait acpi_backlight=vendor"
```

### Install GRUB
```
pacman -S amd-ucode efibootmgr
grub-install --target=x86_64-efi --efi-directory=/efi --bootloader-id=GRUB /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg
```

### Boot to Arch Linux
```
exit
umount -R /mnt
```

## Post Installation
[WIP]

### Xorg
```
pacman -S xorg-server xorg-xinit xorg-apps xf86-video-amdgpu alsa-utils
pacman -S i3-gaps ttf-dejavu rxvt-unicode light
```

