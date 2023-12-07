#!/bin/bash

apt update && apt upgrade

pkg autoclean
pkg clean

termux-setup-storage

apt install curl wget git neovim python grep htop openssh zsh gh neofetch

ln -sf "$PWD/.config/zsh/" $HOME/.config

ln -sf "$PWD/.config/nvim/" $HOME/.config
