#! /bin/bash

pacstrap /mnt linux linux-firmware base base-devel networkmanager emacs grub efibootmgr intel-ucode xorg xorg-xinit i3 lightdm lightdm-gtk3-greeter git pipewire pipewire-alsa pipewire-pulse

systemctl enable lightdm
