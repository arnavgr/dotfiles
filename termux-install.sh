#!/bin/bash

apt update && apt upgrade

pkg autoclean
pkg clean

termux-setup-storage

apt install curl wget git neovim python grep htop openssh zsh gh neofetch

ln -s zsh ~/.config/

ln -s nvim ~/.config/

