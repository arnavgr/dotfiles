#!/bin/bash

# Arch/Void Window Manager Install Script (Nvidia-only, Dracula colorscheme)
# Source: https://www.github.com/arnavgr/dotfiles
# Author: Arnav Grover

# Main function to handle installation process
main() {
    start_installation
    prompt_reboot
}

# Function to start the installation process
start_installation() {
    echo -e "Which distribution are you using?\n1) Void\n2) Arch"
    read -p "Enter number: " distro

    if [[ $distro == 1 ]]; then
        echo -e "This script will install dwm on your Void Linux system.\nIt will also install all Nvidia drivers and settings required. Are you sure you want to continue? (Y/n):"
        read ans

        if [[ $ans == "Y" || $ans == "y" ]]; then
            install_dwm_void
        fi
    elif [[ $distro == 2 ]]; then
        echo -e "What do you want to install?\n1) dwm (Xorg)\n2) hyprland (Wayland)"
        read -p "Enter number: " wm

        echo -e "This script will install all programs and configs related to the window manager you choose.\nIt will also install all Nvidia drivers and settings required. Are you sure you want to continue? (Y/n):"
        read confirm

        if [[ $confirm == "Y" || $confirm == "y" ]]; then
            if [[ $wm == 1 ]]; then
                install_dwm_arch
            elif [[ $wm == 2 ]]; then
                install_hyprland_arch
            fi
        fi
    fi
}

# Function to prompt for reboot
prompt_reboot() {
    echo -e "Installation successful. Do you want to reboot? (Y/n)"
    read reboot

    if [[ $reboot == "Y" || $reboot == "y" ]]; then
        reboot
    fi
}

# Function to install common packages
install_common_packages() {
    sudo pacman -Syu --needed base-devel neovim w3m github-cli neofetch firefox ranger zsh htop feh pamixer pavucontrol flatpak ueberzug atool poppler imagemagick highlight zathura-pdf-poppler brightnessctl dunst pacman-contrib acpi gvim mpv ncmpcpp bluez bluez-utils cups system-config-printer blueman zip unzip unrar nm-connection-editor
}

# Function to install AUR helper
install_aur_helper() {
    git clone https://aur.archlinux.org/yay.git
    cd yay || exit
    makepkg -si --noconfirm
    cd ..
}

# Function to install Xorg packages
install_xorg_packages() {
    sudo pacman -Syu xorg maim xclip xdotool picom libxcb arandr nvidia nvidia-settings nvidia-utils --noconfirm
    yay -S networkmanager-dmenu-git xbanish ttf-firacode-nerd
}

# Function to install Hyprland packages
install_hyprland_packages() {
    sudo pacman -Syu hyprland waybar fuzzel qt5-wayland qt5ct libva linux-headers nvidia-dkms hyprpaper foot wl-clipboard xdg-desktop-portal-hyprland libva-nvidia-driver-git nvidia-utils nvidia-settings --noconfirm
    yay -Syu rofi-lbonn-wayland-git hyprshot getnf
}

# Function to configure Nvidia for Hyprland
configure_nvidia_hyprland() {
    sudo sed -i '$s/$/ nvidia_drm.modeset=1/' /boot/loader/entries/*linux.conf*
    sudo sed -i 's/MODULES=(btrfs)/MODULES=(btrfs nvidia nvidia_modeset nvidia_uvm nvidia_drm)/' /etc/mkinitcpio.conf
    sudo mkinitcpio --config /etc/mkinitcpio.conf --generate
}

# Function to clone and install suckless programs
install_suckless_programs() {
    git clone https://www.github.com/arnavgr/dwm
    git clone https://www.github.com/arnavgr/st
    git clone https://www.github.com/arnavgr/dmenu
    git clone https://www.github.com/arnavgr/slock

    cd dwm && make && sudo make clean install && cd ..
    cd st && make && sudo make clean install && cd ..
    cd dmenu && make && sudo make clean install && cd ..
    cd slock && make && sudo make clean install && cd ..
}

# Function to install dwm on Void Linux
install_dwm_void() {
    sudo xbps-install xorg libXft-devel libX11-devel libXinerama-devel libXrandr-devel imlib2-devel NetworkManager neovim w3m github-cli neofetch firefox ranger zsh htop feh pamixer pavucontrol flatpak ueberzug atool poppler ImageMagick highlight zathura-pdf-poppler brightnessctl dunst acpi gvim mpv ncmpcpp bluez cups system-config-printer blueman zip unzip unrar void-repo-nonfree
    sudo xbps-install -Su
    sudo xbps-install maim xclip xdotool picom libxcb arandr nvidia tlp thermald nix elogind chrony lxappearance polkit-elogind

    install_suckless_programs
}

# Function to install dwm on Arch Linux
install_dwm_arch() {
    install_common_packages
    install_aur_helper
    install_xorg_packages
    install_suckless_programs
}

# Function to install Hyprland on Arch Linux
install_hyprland_arch() {
    install_common_packages
    install_aur_helper
    install_hyprland_packages
    configure_nvidia_hyprland
    
    getnf -i Gohu
}

# Call the main function to start the script
main

