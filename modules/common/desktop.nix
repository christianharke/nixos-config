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
    (i3lock-pixeled.overrideAttrs (oldAttrs: rec {
      src = fetchFromGitLab {
        owner = "christianharke";
        repo = "i3lock-pixeled";
        rev = "take-new-screenshot-each-time";
        sha256 = "1z342m2a68acy4pk4kqc3fv1spkd0fc40rq39rc6vdpqx2rcm846";
      };
    }))
    lm_sensors
    lxappearance
    rofi # Necessary for fontawesome/unicode symbol finder
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
      inactiveOpacity = "0.9";
      opacityRules = [
        "100:_NET_WM_STATE@:32a ~= '_NET_WM_STATE_MAXIMIZED_*'"
        "100:_NET_WM_STATE@:32a *= '_NET_WM_STATE_FULLSCREEN'"
        "100:fullscreen"
        "100:class_g = 'dmenu'"
        "100:name *= 'i3lock'"
        "95:class_g = 'Alacritty' && focused"
      ];
      shadow = true;
      shadowExclude = [
        "window_type *= 'menu'"
      ];
    };

    xserver = {
      enable = true;

      desktopManager.xterm.enable = false;
      windowManager.spectrwm.enable = true;
      displayManager = {
        lightdm.greeters.mini = {
          enable = true;
          user = "christian";
        };
        sessionCommands = ''
          feh --bg-center --randomize /home/christian/Pictures/wallpapers
        '';
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
