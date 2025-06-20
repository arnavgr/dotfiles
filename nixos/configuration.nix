{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 3;
  boot.kernelParams = [ ];

  # TTY font 
  console.font = "Lat2-Terminus16";
  services.greetd = {
  enable = true;
  settings = {
    default_session = {
      command = ''
        ${pkgs.greetd.tuigreet}/bin/tuigreet \
          --cmd "dbus-run-session Hyprland" \
          --theme /etc/tuigreet/dracula.toml \
          --greeting "Welcome to NixOS" \
          --time \
          --remember \
          --asterisks
      '';
      user = "greeter";
    };
  };
};

  # Hostname and networking
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # Locale
  time.timeZone = "Asia/Kolkata";
  i18n.defaultLocale = "en_IN";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN"; LC_IDENTIFICATION = "en_IN"; LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN"; LC_NAME = "en_IN"; LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN"; LC_TELEPHONE = "en_IN"; LC_TIME = "en_IN";
  };

  # Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    QT_QPA_PLATFORM = "wayland";
    QT_STYLE_OVERRIDE = "qt5ct";
  };

  # Audio
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

  # XDG Desktop Portal for Wayland
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  };

  # Polkit agent for Hyprland
  systemd.user.services.polkit-gnome-auth = {
    description = "Polkit GNOME Agent";
    wantedBy = [ "graphical-session.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "always";
    };
  };

  # Prevent suspend on lid close
  services.logind = {
    lidSwitch = "ignore";
    lidSwitchDocked = "ignore";
    lidSwitchExternalPower = "ignore";
    powerKey = "suspend";
  };

  # User
  users.users.arnavgr = {
    isNormalUser = true;
    description = "Arnav";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
    packages = with pkgs; [ ];
  };

  programs.zsh.enable = true;

  # Battery saving
  services.auto-cpufreq.enable = true;

  # Core packages
  environment.systemPackages = with pkgs; [
    firefox neovim w3m gh ranger zsh htop fastfetch git nwg-look terminus_font
    unzip zip unrar atool highlight file pciutils usbutils auto-cpufreq 
    pulsemixer pavucontrol mpv ncmpcpp feh imagemagick poppler_utils zathura
    ueberzug brightnessctl acpi dunst waybar rofi-wayland foot hyprpaper
    hyprpicker networkmanagerapplet lsd wl-clipboard cliphist jq flatpak greetd.tuigreet 
    xfce.thunar gvfs fuzzel grim slurp gtk3 polkit_gnome libva python3Packages.requests

    libsForQt5.qt5ct qt5.qtwayland qt5.qtsvg
  ];

  fonts.packages = [
    pkgs.nerd-fonts.jetbrains-mono
    pkgs.gohufont
  ];

  programs.dconf.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.auto-optimise-store = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "24.11";
}


