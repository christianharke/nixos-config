# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware/default.nix
      ./projects/blueconnect.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    hostName = "n75";
    wireless.enable = true;
  };

  time.timeZone = "Europe/Zurich";

  nixpkgs.config.allowUnfree = true;

  environment.variables = {
    EDITOR = "vim";
  };

  fonts.fonts = with pkgs; [
    nerdfonts
    ubuntu_font_family
  ];

  fileSystems."/mnt/home" = {
      device = "//bluecare-s54/homeshares$/chr";
      fsType = "cifs";
      options = let
        # this line prevents hanging on network split
        automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";

      in ["${automount_opts},credentials=/home/christian/.smbcredentials"];
  };

  virtualisation.virtualbox.host.enable = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  security.pam.enableSSHAgentAuth = true;

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware = {
    bluetooth.enable = true;
    pulseaudio = {
      enable = true;
      package = pkgs.pulseaudioFull;
    };
  };

  services.compton = {
    enable = true;
    fade = true;
    fadeDelta = 5;
    fadeExclude = [ "window_type *= 'menu'" "name ~= 'Firefox$'" "focused = 1" ];
    inactiveOpacity = "0.8";
    opacityRules = [ "100:name *= 'i3lock'" "100:name *= 'rofi'" "95:class_g = 'URxvt' && !_NET_WM_STATE@:32a" "0:_NET_WM_STATE@:32a *= '_NET_WM_STATE_HIDDEN'" ];
    shadow = true;
    shadowExclude = [ "window_type *= 'menu'" "name ~= 'Firefox$'" "focused = 1" ];
  };

  services.openvpn.servers.bluecare = {
    autoStart = false;
    config = "config /home/christian/.ovpn/chr@vpfwblue.bluecare.ch.ovpn";
    updateResolvConf = true;
  };

  services.xserver = {
    enable = true;
    layout = "ch";

    # Touchpad settings
    libinput = {
      enable = true;
      naturalScrolling = true;
      disableWhileTyping = true;
      sendEventsMode = "disabled-on-external-mouse";
    };

    dpi = 96;

    desktopManager.xterm.enable = false;

    displayManager = {
      sessionCommands = ''
        eval $(op signin my)
        gpg-connect-agent /bye
      '';
    };

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

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.christian = {
    isNormalUser = true;
    uid = 1000;
    extraGroups = [
      "wheel"
      "vboxusers"
    ];
    initialPassword = "changeme";
    packages = with pkgs; [ 
      _1password
      bat
      file
      firefox
      gimp
      git
      gnupg
      google-chrome
      jq
      killall
      lazydocker
      lazygit
      libreoffice
      mupdf
      neofetch
      nixops
      peek
      pinentry
      ranger
      rxvt_unicode
      screenfetch
      slack
      spotifywm
      stow
      tmux
      tmuxinator
      tree
      unzip
      vim
      vscode
      xclip
    ];
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.03"; # Did you read the comment?

}
