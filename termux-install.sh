#!/bin/bash

# Upgrade installed packages
pkg upgrade

# Clean up cached package files
pkg autoclean
pkg clean

# Grant storage permissions
termux-setup-storage

# Install essential packages
pkg install curl wget git neovim python grep htop openssh zsh gh neofetch

# Install Termux ADB
curl -s https://raw.githubusercontent.com/nohajc/termux-adb/master/install.sh | bash

# Create necessary directories
mkdir -p $HOME/.config

# Create symbolic links for configuration files
ln -sf "$PWD/bin/" $HOME/.local
ln -sf "$PWD/.config/zsh/" $HOME/.config
ln -sf "$PWD/.config/nvim/" $HOME/.config
ln -sf "$PWD/.config/ranger/" $HOME/.config
ln -sf "$PWD/.config/neofetch/" $HOME/.config

# Copy zsh environment configuration
cp .zshenv $HOME

# Change default shell to zsh
chsh -s zsh

# Install Termux Notion
curl -fsSL https://raw.githubusercontent.com/arnavgr/termux-notion/main/install.sh | bash

# Run getnf command to set up Termux Notion
getnf

