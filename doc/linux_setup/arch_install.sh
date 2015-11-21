# https://wiki.archlinux.org/index.php/USB_flash_installation_media
sudo fdisk -l;
# /dev/sdb1

sudo dd bs=4M if=$HOME/archlinux-2015.11.01-dual.iso of=/dev/sdb && sync;

# Reboot from USB
# Boot Arch Linux x86_64

# ping -c 3 www.google.com;

# check if it's efi
# ls /sys/firmware/efi/efivars;
# if exists, it's efi



###########################
# INSTALL ONLY Arch Linux #
###########################
# https://wiki.archlinux.org/index.php/Beginners'_guide
# https://wiki.archlinux.org/index.php/Installation_guide

# find out what partitions you have
fdisk -l;
lsblk /dev/sdx;
parted /dev/sdx print;

# erase all
sgdisk --xap-all /dev/sdxY;

# format partitions
mkfs.ext4 /dev/sdxY;

# mount the partition
mount /dev/sdxY /mnt;





##################################
# INSTALL Arch Linux (DUAL-BOOT) #
##################################
# https://wiki.archlinux.org/index.php/Beginners'_guide
# https://wiki.archlinux.org/index.php/Installation_guide

# find out what partitions you have
sudo fdisk -l;
parted /dev/sdx print;








# install basic libraries
pacstrap /mnt base base-devel;
pacman --noconfirm -Syyu;

genfstab -U /mnt > /mnt/etc/fstab;
arch-chroot /mnt /bin/bash;

# set username
echo gyuho > /etc/hostname;
# vim /etc/hosts;

# set password
passwd

# install bootloader
pacman --noconfirm -S grub os-prober;
grub-install --recheck /dev/sdxY;
grub-mkconfig -o /boot/grub/grub.cfg;

exit;
reboot;


# set language
vim /etc/locale.gen; # remove # from en_US.UTF-8
locale-gen;
echo LANG=en_US.UTF-8 > /etc/locale.conf;
export LANG=en_US.UTF-8;

# set timezone
ln -s /usr/share/zoneinfo/America/Los_Angeles /etc/localtime;

# set hardware clock to UTC
hwclock --systohc --utc;
