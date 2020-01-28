{ config, pkgs, ... }:

{

  fonts.fonts = with pkgs; [
    nerdfonts
    ubuntu_font_family
  ];

  services = {
    autorandr.enable = true;

    compton = {
      enable = true;
      fade = true;
      fadeDelta = 5;
      fadeExclude = [
        "window_type *= 'menu'"
      ];
      inactiveOpacity = "0.8";
      opacityRules = [
        "0:_NET_WM_STATE@:32a *= '_NET_WM_STATE_HIDDEN'"
        "100:name *= 'i3lock'"
        "100:name *= 'rofi'"
        "65:class_g = 'Alacritty' && focused != 1"
        "70:class_g = 'Alacritty' && focused = 1"
      ];
      shadow = true;
      shadowExclude = [
        "window_type *= 'menu'"
        "focused = 1"
      ];
    };

    xserver = {
      enable = true;

      desktopManager.xterm.enable = false;

      windowManager.i3 = {
        enable = true;
        package = pkgs.i3-gaps;
        extraPackages = with pkgs; [
          acpi
          compton
          dunst
          feh
          fortune
          i3blocks
          i3lock-fancy
          i3lock-pixeled
          libnotify
          lm_sensors
          lxappearance
          playerctl
          rofi
          sysstat
        ];
      };

      xautolock = {
        enable = true;
        enableNotifier = true;
        extraOptions = [ "-detectsleep" ];
        locker = "/run/current-system/sw/bin/i3lock-pixeled";
        notifier = ''/run/current-system/sw/bin/notify-send "Locking in 10 seconds"'';
        notify = 10;
        nowlocker = "/run/current-system/sw/bin/i3lock-pixeled";
        time = 10;
      };

      serverFlagsSection = ''
          Option "BlankTime" "15"
          Option "StandbyTime" "15"
          Option "SuspendTime" "15"
          Option "OffTime" "15"
      '';
    };
  };
}
