#!/bin/bash
umount -R /mnt
timedatectl set-ntp true
fdisk /dev/nvme0n1 << "EOF"
g
n


+300M
n



t
1
1
t
2
23
w
EOF
mkfs.ext4 /dev/nvme0n1p2 << "EOF"
y
EOF
mkfs.fat -F 32 /dev/nvme0n1p1
rm -rf /etc/pacman.conf
ln -sf /root/dotfiles/pacman.conf /etc/
mount /dev/nvme0n1p2 /mnt
mount --mkdir /dev/nvme0n1p1 /mnt/boot
pacstrap /mnt base base-devel linux linux-firmware networkmanager emacs man-db man-pages texinfo amd-ucode grub efibootmgr nano xorg-server i3-gaps dmenu firefox gnome-terminal lightdm lightdm-gtk-greeter i3status neofetch git discord pipewire pipewire-alsa pipewire-pulse pavucontrol steam go bluez bluez-utils openssh bash-completion mesa lib32-mesa vulkan-intel
mount --mkdir /dev/sda1 /mnt/mnt/steam
genfstab -U /mnt >> /mnt/etc/fstab
echo "root:$1" >> /mnt/pass.txt
echo "emil:$2" >> /mnt/pass.txt
arch-chroot /mnt /bin/bash << "EOF"
ln -sf /usr/share/zoneinfo/Europe/Stockholm /etc/localtime
hwclock --systohc
cat >> /etc/locale.gen << "END"
en_US.UTF-8 UTF-8
END
locale-gen
cat >> /etc/locale.conf << "END"
LANG=en_US.UTF-8
END
cat >> /etc/vconsole.conf << "END"
KEYMAP=sv-latin1
END
cat >> /etc/hostname << "END"
arch-desktop
END
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
rm -rf /etc/default/grub
ln -sf grub /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg
systemctl enable NetworkManager
systemctl enable lightdm
systemctl enable bluetooth
systemctl enable sshd
useradd -g wheel -m emil
chpasswd < pass.txt
rm -rf pass.txt
echo "%wheel ALL=(ALL:ALL) NOPASSWD :ALL" >> /etc/sudoers 
su emil
cd ~
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm
cd ..
rm -rf yay
mkdir github
exit
sed -n '$d' /etc/sudoers
sed -n '$d' /etc/sudoers
echo "%wheel ALL=(ALL:ALL) ALL" >> /etc/sudoers
ln -sf /home/emil/github/dotfiles/pacman.conf /etc/
rm -rf /etc/X11/xorg.conf.d
ln -sf /home/emil/github/dotfiles/xorg.conf.d /etc/X11/
su emil
cd ~/github/
git clone https://www.github.com/Emil-Engberg/Emacs_conf
ln -sf ~/github/Emacs_conf/ ~/.emacs.d
git clone https://www.github.com/Emil-Engberg/dotfiles.git/
ln -sf ~/github/dotfiles/.config ~/
ln -sf ~/github/dotfiles/.gitconfig ~/
ln -sf ~/github/dotfiles/.global_gitignore ~/
EOF
