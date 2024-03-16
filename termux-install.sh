#!/bin/bash

pkg upgrade

pkg autoclean
pkg clean

termux-setup-storage

pkg install curl wget git neovim python grep htop openssh zsh gh neofetch ranger lsd

curl -s https://raw.githubusercontent.com/nohajc/termux-adb/master/install.sh | bash

mkdir -p $HOME/.config

ln -sf "$PWD/.config/zsh/" $HOME/.config

ln -sf "$PWD/.config/nvim/" $HOME/.config

ln -sf "$PWD/.config/ranger/" $HOME/.config

ln -sf "$PWD/.config/neofetch/" $HOME/.config

ln -sf "$PWD/.zshenv/" $HOME/

chsh -s zsh
