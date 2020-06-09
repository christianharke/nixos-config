{ config, pkgs, ... }:

{

  fonts.fonts = with pkgs; [
    nerdfonts
    ubuntu_font_family
  ];

  environment.systemPackages = with pkgs; [
    acpi
    dmenu
    dunst libnotify
    feh
    i3lock-pixeled
    lm_sensors
    lxappearance
    rofi # Necessary for fontawesome/unicode symbol finder
  ];

  programs.xss-lock = {
    enable = true;
    lockerCommand = "/run/current-system/sw/bin/i3lock-pixeled";
  };

  services = {
    autorandr.enable = true;

    compton = {
      enable = true;
      fade = true;
      fadeDelta = 5;
      fadeExclude = [
        "window_type *= 'menu'"
        #"class_g = 'Firefox' && window_type = 'utility'"
        #"class_g = 'Thunderbird' && window_type = 'utility'"
        "window_type = 'utility'"
      ];
      inactiveOpacity = "0.9";
      opacityRules = [
        "100:_NET_WM_STATE@:32a ~= '_NET_WM_STATE_MAXIMIZED_*'"
        "100:_NET_WM_STATE@:32a *= '_NET_WM_STATE_FULLSCREEN'"
        "100:fullscreen"
        "100:class_g = 'dmenu'"
        "100:name *= 'i3lock'"
        "100:class_g *= 'Microsoft Teams'"
        "95:class_g = 'Alacritty' && focused"

        # Exclude special Firefox/Thunderbird dropdowns.
        # Ref: https://github.com/chjj/compton/issues/247
        #"100:class_g = 'Firefox' && argb"
        #"100:class_g = 'Thunderbird' && argb"
        "100:window_type = 'utility'"
      ];
      shadow = true;
      shadowExclude = [
        "window_type *= 'menu'"
        #"class_g = 'Firefox' && window_type = 'utility'"
        #"class_g = 'Thunderbird' && window_type = 'utility'"
        "window_type = 'utility'"
      ];
    };

    xserver = {
      enable = true;

      desktopManager.xterm.enable = false;
      windowManager.spectrwm.enable = true;
      displayManager.sessionCommands = ''
        feh --bg-fill --randomize /home/christian/Pictures/wallpapers
      '';

      serverFlagsSection = ''
          Option "BlankTime" "15"
          Option "StandbyTime" "15"
          Option "SuspendTime" "15"
          Option "OffTime" "15"
      '';
    };
  };
}
