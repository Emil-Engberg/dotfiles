#! /bin/bash

timedatectl set-ntp true

pacstrap /mnt linux linux-firmware base base-devel networkmanager emacs grub efibootmgr intel-ucode xorg xorg-xinit i3 lightdm lightdm-gtk3-greeter git pipewire pipewire-alsa pipewire-pulse brightnessctl firefox

genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt

ln -sf /usr/share/zoneinfo/Europe/Stockholm /etc/localtime
hwclock --systohc

echo "en_US.UTF-8" >> /etc/locale.gen
locale-gen
touch /etc/locale.conf
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo "KEYMAP=sv-latin1" >>/etc/vconsole.conf
echo "arch-laptop" >> /etc/hostname

grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable lightdm
systemctl enable NetworkManager

useradd -G wheel -m emil
echo "%wheel ALL=(ALL) ALL" >> /etc/sudoers

