{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    bibata-cursors
    dracula-theme
  ];

  # Cursor theme system-wide
  environment.etc."X11/cursor.theme".text = ''
    XCURSOR_THEME=Bibata-Modern-Classic
    XCURSOR_SIZE=24
  '';

  services.xserver.displayManager.sessionCommands = ''
    export XCURSOR_THEME=Bibata-Modern-Classic
    export XCURSOR_SIZE=24
  '';

  # Environment variables for GTK/Wayland apps
  environment.variables = {
    GTK_THEME = "Dracula";
    XCURSOR_THEME = "Bibata-Modern-Classic";
    XCURSOR_SIZE = "24";
    GDK_BACKEND = "wayland,x11";
  };
}

