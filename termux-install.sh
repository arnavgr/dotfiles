#!/bin/bash

apt update && apt upgrade

pkg autoclean
pkg clean

termux-setup-storage

apt install curl wget git neovim python grep htop openssh zsh gh neofetch ranger lsd

ln -sf "$PWD/.config/zsh/" $HOME/.config

ln -sf "$PWD/.config/nvim/" $HOME/.config

ln -sf "$PWD/.config/ranger/" $HOME/.config

ln -sf "$PWD/.config/neofetch/" $HOME/.config

ln -sf "$PWD/.zshenv/" $HOME/

git config --global user.email "arnavgr@hotmail.com"

git config --global user.name "arnavgr"

chsh
