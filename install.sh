# This install all packages along with aur
sudo pacman -Syu --needed base-devel nvim w3m github-cli neofetch firefox ranger zsh htop feh pamixer flatpak ueberzug atool poppler imagemagick highlight zathura-pdf-poppler brightnessctl dunst maim xclip picom pacman-contrib xdotool acpi gvim mpv ncmpcpp libxcb bluez bluez-utils
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..
yay -S ttf-firacode-nerd udiskie networkmanager-dmenu-git xbanish

# This is used to symlink config files to .config
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
ln -s "$PWD/X11" $HOME
ln -s "$PWD/.config/networkmanager-dmenu/" $HOME/.config



