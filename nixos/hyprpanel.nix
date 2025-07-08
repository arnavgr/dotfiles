{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    hyprpanel
    libgtop
    libsoup_3
    upower
  ];

  services.upower.enable = true;
}

