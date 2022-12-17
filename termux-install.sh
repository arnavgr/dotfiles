#!/bin/bash

pkg update

pkg upgrade

pkg autoclean
pkg clean

termux-setup-storage

pkg install curl wget git neovim python grep htop openssh zsh gh neofetch

ln -s zsh ~/.config/

ln -s nvim ~/.config/

