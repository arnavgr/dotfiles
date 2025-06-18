{ config, pkgs, lib, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  # Bootloader and system basics
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 3;
  boot.kernelParams = [ "quiet" "splash" ];
  boot.plymouth.enable = true;
  boot.plymouth.theme = "bgrt";
  boot.loader.systemd-boot.consoleMode = "auto";

  systemd.services."getty@tty1".enable = false;
  systemd.services."getty@tty1".wantedBy = lib.mkForce [];
  systemd.services."getty@tty1".restartIfChanged = false;

# Hostname and network
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # Graphics drivers (Intel only, NVIDIA disabled)
  services.xserver.videoDrivers = [ "intel" ];
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
  boot.blacklistedKernelModules = [ "nvidia" "nouveau" ];

  # Locale and time
  time.timeZone = "Asia/Kolkata";
  i18n.defaultLocale = "en_IN";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN"; LC_IDENTIFICATION = "en_IN"; LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN"; LC_NAME = "en_IN"; LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN"; LC_TELEPHONE = "en_IN"; LC_TIME = "en_IN";
  };

  # X11 and Plasma
  services.xserver.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm.enable = true;
  services.xserver.xkb = { layout = "us"; };

  # Hyprland Wayland setup
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";  # Helps apps like Chromium-based browsers on Wayland
  };

  # PipeWire
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Bluetooth, printing, Avahi
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  services.printing.enable = true;
  services.printing.drivers = [ pkgs.gutenprint pkgs.cnijfilter2 ];
  services.avahi = {
    enable = true;
    nssmdns = true;
    openFirewall = true;
  };

  # User
  users.users.arnavgr = {
  isNormalUser = true;
  description = "Arnav";
  extraGroups = [ "networkmanager" "wheel" ];
  shell = pkgs.zsh;
  packages = with pkgs; [ kdePackages.kate ];
  };

  programs.zsh.enable = true;

  # Packages
  environment.systemPackages = with pkgs; [
    firefox git curl neovim w3m gh ranger fzf zsh htop fastfetch
    unzip zip unrar atool highlight file pciutils usbutils
    pamixer mpv ncmpcpp feh imagemagick poppler_utils zathura
    ueberzug brightnessctl acpi dunst waybar rofi-wayland foot
    hyprpaper hyprpicker nwg-look networkmanagerapplet lsd
  ];

  fonts.packages = [
    pkgs.nerd-fonts.jetbrains-mono
    pkgs.gohufont
  ];

  # Enable flakes and garbage collection
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.auto-optimise-store = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "24.11";
}
