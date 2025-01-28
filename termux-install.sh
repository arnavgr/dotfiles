#!/bin/bash

# Upgrade installed packages
pkg upgrade

# Clean up cached package files
pkg autoclean
pkg clean

# Grant storage permissions
termux-setup-storage

# Install essential packages
pkg install curl wget lsd neovim python grep htop openssh zsh gh neofetch ncurses-utils

# Create necessary directories
mkdir -p $HOME/.config

# Create symbolic links for configuration files
ln -sf "$PWD/bin/" $HOME/.local
ln -sf "$PWD/.config/zsh/" $HOME/.config
ln -sf "$PWD/.config/nvim/" $HOME/.config
ln -sf "$PWD/.config/ranger/" $HOME/.config
ln -sf "$PWD/.config/neofetch/" $HOME/.config

# Applying android neofetch
cp $HOME/.config/neofetch/android $HOME/.config/neofetch/config.conf

# Applying Dracula Theme on Termux
cp extras/colors.properties $HOME/.termux

# Copy zsh environment configuration
cp .zshenv $HOME

# Change default shell to zsh
chsh -s zsh

# Install Termux-NF
curl -fsSL https://raw.githubusercontent.com/arnavgr/termux-nf/main/install.sh | bash

#removes termux help guide at start
touch ~/.hushlogin

# Run getnf command to set up Termux-NF
getnf


