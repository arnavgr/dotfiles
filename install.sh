# ask what you want to install
echo what do you want to install: 1) dwm(xorg) 2)hyprland(wayland) 

read wm

if [ $wm = 1 ]; then
  git clone https://www.github.com/arnavgr/dwm
  git clone https://www.github.com/arnavgr/st
  git clone https://www.github.com/arnavgr/dmenu
  git clone https://www.github.com/arnavgr/slock




# This install all packages along with aur
sudo pacman -Syu --needed base-devel nvim w3m github-cli neofetch firefox ranger zsh htop feh pamixer pavucontrol flatpak ueberzug atool poppler imagemagick highlight zathura-pdf-poppler brightnessctl dunst pacman-contrib acpi gvim mpv ncmpcpp bluez bluez-utils
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..
yay -S udiskie networkmanager-dmenu-git xbanish

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


sudo pacman -Syu maim xclip xdotool picom libxcb
