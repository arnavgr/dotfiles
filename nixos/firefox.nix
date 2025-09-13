{ config, lib, pkgs, ... }:

let
  # Set your Firefox profile path
  firefoxProfile = "/home/arnavgr/.mozilla/firefox/hu6tarzd.default";

  # Fetch PotatoFox theme (replace rev/sha256 if you want to pin it)
  potatofox = pkgs.fetchgit {
    url = "https://codeberg.org/awwpotato/PotatoFox.git";
    rev = "HEAD";  # You can replace with a commit hash for locking
    sha256 = "N5zgBbL9a7UAqVR6G1YKOdc/yFEvJr7o9FUNUGXJdQg=";
  };
in
{
  # Apply Firefox custom preferences via enterprise policies
  environment.etc."firefox/policies/policies.json".source = pkgs.writeText "firefox-policies.json" ''
    {
      "policies": {
        "Preferences": {
          "toolkit.legacyUserProfileCustomizations.stylesheets": true,
          "layout.css.has-selector.enabled": true,
          "svg.context-properties.content.enabled": true,
          "browser.urlbar.suggest.calculator": true,
          "browser.urlbar.unitConversion.enabled": true,
          "browser.urlbar.trimHttps": true,
          "browser.urlbar.trimURLs": true,
          "browser.profiles.enabled": true,
          "widget.gtk.rounded-bottom-corners.enabled": true,
          "browser.compactmode.show": true,
          "widget.gtk.ignore-bogus-leave-notify": 1,
          "browser.tabs.allow_transparent_browser": true,
          "browser.uidensity": 1,
          "browser.aboutConfig.showWarning": false
        }
      }
    }
  '';

  # Copy PotatoFox chrome folder into your Firefox profile
  system.activationScripts.potatofox = lib.stringAfter [ "users" ] ''
    mkdir -p "${firefoxProfile}/chrome"
    cp -rT "${potatofox}/chrome" "${firefoxProfile}/chrome"
    chown -R ${config.users.users.arnavgr.name}:${config.users.users.arnavgr.group} "${firefoxProfile}/chrome"
  '';
}

