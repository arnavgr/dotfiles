#!/bin/sh

# Arch Window Manager Install Script(nvidia-only, dracula colorscheme)
# Source: https://www.github.com/arnavgr/dotfiles
# Author: Arnav Grover


# ask what you want to install
echo -e "what do you want to install\n 1) dwm(xorg)\n 2)hyprland(wayland)"

read -p "enter number : " wm

echo -e "this script will install all programs and configs related to the window manager you choose\nit will also install all nvidia drivers and settings required are you sure you want to continue(Y/n):"

read confirm

if [[ $confirm == "Y" || $confirm == "y" ]]; then
  sudo pacman -Syu --needed base-devel nvim w3m github-cli neofetch firefox ranger zsh htop feh pamixer pavucontrol flatpak ueberzug atool poppler imagemagick highlight zathura-pdf-poppler brightnessctl dunst pacman-contrib acpi gvim mpv ncmpcpp bluez bluez-utils cups system-config-printer blueman bluetoothctl zip unzip unrar nm-connection-editor --no-confirm
  git clone https://aur.archlinux.org/yay.git
  cd yay
  makepkg -si --noconfirm
  cd ..
  yay -S udiskie aurutils nwg-look timeshift envycontrol
  
  if [ $wm = 1 ]; then

    # This install xorg packages along with aur packages
    sudo pacman -Syu xorg maim xclip xdotool picom libxcb arandr nvidia nvidia-settings nvidia-utils --no-confirm
    yay -S networkmanager-dmenu-git xbanish ttf-firacode-nerd
  
    # This clones all my sukcless programs  
    git clone https://www.github.com/arnavgr/dwm
    git clone https://www.github.com/arnavgr/st
    git clone https://www.github.com/arnavgr/dmenu
    git clone https://www.github.com/arnavgr/slock

    # This installs dwm along with all suckless programs
    cd dwm && make && sudo make clean install && cd ..
    cd st && make && sudo make clean install && cd ..
    cd dmenu && make && sudo make clean install && cd ..
    cd slock && make && sudo make clean install && cd ..

    # This symlinks all configs to .config  
    ln -s "$PWD/.config/zsh/" $HOME/.config
    ln -s "$PWD/.zshenv" $HOME
    ln -s "$PWD/.config/nvim" $HOME/.config
    ln -s "$PWD/.config/ranger" $HOME/.config
    ln -s "$PWD/.config/zathura" $HOME/.config
    ln -s "$PWD/.config/picom" $HOME/.config
    ln -s "$PWD/.config/dunst" $HOME/.config
    ln -s "$PWD/.config/neofetch" $HOME/.config
    ln -s "$PWD/bin" $HOME
    ln -s "$PWD/.xintrc" $HOME
    ln -s "$PWD/.config/networkmanager-dmenu/" $HOME/.config

  elif [ $wm = 2 ]; then
  
    # This install all packages along with aur
    sudo pacman -Syu fuzzel qt5-wayland qt5ct libva linux-headers nvidia-dkms hyprpaper foot ttf-bigblueterminal-nerd
    yay -S hyprland-nvidia-git aur-utils rofi-lbonn-wayland-git waybar-hyprland-git libva-nvidia-driver-git

    # This configures nvidia to work on hyprland
    sudo sed -i '$s/$/ nvidia_drm.modeset=1/' /boot/loader/entries/*linux.conf*        
    sudo sed -i 's/MODULES=(btrfs)/MODULES=(btrfs nvidia nvidia_modeset nvidia_uvm nvidia_drm)/' /etc/mkinitcpio.conf
    sudo mkinitcpio --config /etc/mkinitcpio.conf --generate /boot/initramfs-custom.img
    echo -e "options nvidia-drm modeset=1" | sudo tee -a /etc/modprobe.d/nvidia.conf 

# This symlinks all configs to .config  
  ln -s "$PWD/.config/zsh/" $HOME/.config
  ln -s "$PWD/.zshenv" $HOME
  ln -s "$PWD/.config/nvim" $HOME/.config
  ln -s "$PWD/.config/ranger" $HOME/.config
  ln -s "$PWD/.config/zathura" $HOME/.config
  ln -s "$PWD/.config/foot" $HOME/.config
  ln -s "$PWD/.config/dunst" $HOME/.config
  ln -s "$PWD/.config/neofetch" $HOME/.config
  ln -s "$PWD/bin" $HOME
  ln -s "$PWD/.config/hypr" $HOME/.config
  ln -s "$PWD/.config/rofi/" $HOME/.config
  ln -s "$PWD/.config/waybar/" $HOME/.config

 
  fi
fi


echo -e "installation successfull do you want to reboot(Y/n)"

read reboot

if [[ $reboot == "Y" || $reboot == "y" ]]; then
  reboot
fi
