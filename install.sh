# This install all packages along with aur
sudo pacman -Syu --needed base-devel nvim w3m github-cli neofetch firefox ranger zsh lxappearance htop feh pamixer flatpak ueberzug atool poppler imagemagick highlight zathura-pdf-poppler brightnessctl dunst maim xclip picom
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd -
yay -S ttf-firacode-nerd checkupdates-with-aur 

# This is used to symlink config files to .config
ln -s "$PWD/.config/zsh/" ~/.config
ln -s "$PWD/.zshenv" ~
ln -s "$PWD/.config/nvim" ~/.config
ln -s "$PWD/.config/ranger" ~/.config
ln -s "$PWD/.config/zathura" ~/.config
ln -s "$PWD/.config/picom" ~/.config
ln -s "$PWD/.config/dunst" ~/.config
ln -s "$PWD/.config/neofetch" ~/.config
sudo ln -s "$PWD/bin" /usr/bin



