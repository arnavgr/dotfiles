{ config, pkgs, lib, ... }:

let
  home = "/home/${builtins.getEnv "USER"}";
  dotcfg = "${home}/dotfiles/.config";
  extras = "${home}/dotfiles/extras";
  configDirs = [
    "dunst" "fastfetch" "foot" "zathura"
    "hypr" "Kvantum" "nixpkgs" "zsh"   
    "nvim" "picom" "polybar" "qt5ct"
    "qt6ct" "ranger" "rofi" "waybar" 
  ];
in {
  system.activationScripts.linkDotfiles = lib.stringAfter [ "etc" ] ''
    echo "Linking dotfiles..."

    mkdir -p ${home}/.config
    mkdir -p ${home}/.local

    # Link .config folders
    ${lib.concatStringsSep "\n" (map (name: ''
      src="${dotcfg}/${name}"
      dst="${home}/.config/${name}"
      if [ -e "$dst" ] || [ -L "$dst" ]; then
        echo "Skipping existing: $dst"
      else
        ln -sfn "$src" "$dst"
        echo "Linked: $dst → $src"
      fi
    '') configDirs)}

    # Link .zshenv
    if [ ! -e "${home}/.zshenv" ]; then
      ln -sfn "${home}/dotfiles/.zshenv" "${home}/.zshenv"
      echo "Linked: .zshenv"
    else
      echo "Skipping existing: .zshenv"
    fi

    # Link wallpapers to ~/wallpapers
    if [ ! -e "${home}/wallpapers" ]; then
      ln -sfn "${extras}/wallpapers" "${home}/wallpapers"
      echo "Linked: wallpapers"
    else
      echo "Skipping existing: wallpapers"
    fi

    # Link extras/bin to ~/.local/bin
    mkdir -p ${home}/.local
    if [ ! -e "${home}/.local/bin" ]; then
      ln -sfn "${extras}/bin" "${home}/.local/bin"
      echo "Linked: .local/bin"
    else
      echo "Skipping existing: .local/bin"
    fi
  '';

 # Link all files from dotfiles/nixos to /etc/nixos
  system.activationScripts.linkSystemConfig = lib.stringAfter [ "etc" ] ''
    echo "[dotfiles.nix] Linking all system config files from ~/dotfiles/nixos to /etc/nixos..."

    for file in "${syscfg}"/*; do
      base="$(basename "$file")"
      target="/etc/nixos/$base"
      if [ ! -e "$target" ] || [ -L "$target" ]; then
        ln -sf "$file" "$target"
        echo "Linked: $target → $file"
      else
        echo "Skipping existing: $target"
      fi
    done
  '';

}

