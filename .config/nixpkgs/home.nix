# ~/.config/nixpkgs/home.nix
{ config, pkgs, ... }:

{
  home.username = "arnavgr";
  home.homeDirectory = "/home/arnavgr";

  home.stateVersion = "24.11";

  # User-only apps
  home.packages = with pkgs; [
    neovim w3m gh ranger zsh htop fastfetch
    unzip zip unrar atool highlight
    pamixer mpv ncmpcpp feh imagemagick poppler_utils zathura zathura-pdf-poppler
    ueberzug brightnessctl acpi dunst waybar rofi-wayland foot hyprpaper
    hyprpicker lsd wl-clipboard cliphist jq
    thunar fuzzel grim slurp python3Packages.requests
    neofetch
  ];

  # Programs
  programs.zsh.enable = true;
  programs.neovim.enable = true;
  programs.ranger.enable = true;
  programs.zathura.enable = true;

  # Dotfiles
  home.file = {
    ".zshenv".source = ./dotfiles/.zshenv;
    ".icons".source = ./dotfiles/.icons;
    ".themes".source = ./dotfiles/.themes;
    ".local/wallpapers".source = ./dotfiles/extras/wallpapers;
    ".local/bin".source = ./dotfiles/extras/bin;

    ".config/fastfetch".source = ./dotfiles/.config/fastfetch;
    ".config/ranger".source = ./dotfiles/.config/ranger;
    ".config/zathura".source = ./dotfiles/.config/zathura;
    ".config/catnip".source = ./dotfiles/.config/catnip;
    ".config/foot".source = ./dotfiles/.config/foot;
    ".config/Kvantum".source = ./dotfiles/.config/Kvantum;
    ".config/nvim".source = ./dotfiles/.config/nvim;
    ".config/qt5ct".source = ./dotfiles/.config/qt5ct;
    ".config/qt6ct".source = ./dotfiles/.config/qt6ct;
    ".config/rofi".source = ./dotfiles/.config/rofi;
    ".config/waybar".source = ./dotfiles/.config/waybar;
    ".config/zsh".source = ./dotfiles/.config/zsh;
    ".config/hypr".source = ./dotfiles/.config/hypr;

    "/etc/nixos/configuration.nix".source = ./dotfiles/nixos/configuration.nix;
    "/etc/nixos/hardware-configuration.nix".source = ./dotfiles/nixos/hardware-configuration.nix;
  };

  # Dconf for GTK settings
  programs.dconf.enable = true;
}

