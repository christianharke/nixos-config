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
    lockerCommand = "${pkgs.i3lock-pixeled}/bin/i3lock-pixeled";
  };

  systemd.user.services.dunst = {
    description = "Dunst notification daemon";
    documentation = [ "man:dunst(1)" ];
    partOf = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "dbus";
      BusName = "org.freedesktop.Notifications";
      ExecStart = "${pkgs.dunst}/bin/dunst";
    };
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
      inactiveOpacity = 0.9;
      opacityRules = [
        "100:_NET_WM_STATE@:32a ~= '_NET_WM_STATE_MAXIMIZED_*'"
        "100:_NET_WM_STATE@:32a *= '_NET_WM_STATE_FULLSCREEN'"
        "100:fullscreen"

        # App specifics
        "100:class_g = 'dmenu'"
        "100:class_g *= 'Microsoft Teams'"
        "100:name = 'as_toolbar'" # Zoom screen sharing toolbar
        "100:name *= 'i3lock'"
        "100:window_type = 'utility'" # Firefox/Thunderbird dropdowns
        "95:class_g = 'Alacritty' && focused"
      ];
      shadow = true;
      shadowExclude = [
        "window_type *= 'menu'"

        # App specifics
        "name = 'as_toolbar'" # Zoom screen sharing toolbar
        "name = 'cpt_frame_window'" # Zoom screen sharing frame
        "window_type = 'utility'" # Firefox/Thunderbird dropdowns
      ];
    };

    xserver = {
      enable = true;

      desktopManager.xterm.enable = false;
      windowManager.spectrwm.enable = true;
      displayManager.sessionCommands = ''
        feh --no-fehbg --bg-fill --randomize /home/christian/Pictures/wallpapers
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
