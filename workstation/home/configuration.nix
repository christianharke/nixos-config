{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
    ];

  boot.loader.grub = {
    enable = true;
    version = 2;
    device = "/dev/sda"; # or "nodev" for efi only
  };

  networking = {
    hostName = "nb-nixos-01";
    wireless.enable = true;
  };

  time.timeZone = "Europe/Zurich";

  nixpkgs.config.allowUnfree = true;

  environment.pathsToLink = [ "/libexec" ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    acpi
    compton
    dunst
    feh
    i3-gaps
    i3blocks-gaps
    i3lock-fancy
    libnotify
    lm_sensors
    lxappearance
    playerctl
    rofi
  ];

  fonts.fonts = with pkgs; [
    nerdfonts
    ubuntu_font_family
  ];

  virtualisation.virtualbox.host.enable = true;

  sound.enable = true;
  hardware.pulseaudio.enable = true;

  services.xserver = {
    enable = true;
    layout = "ch";
    libinput.enable = true; # Enable touchpad support
    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
    };
  };

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
      firefox
      git
      jq
      keychain
      libreoffice
      nixops
      ranger
      rxvt_unicode
      spotifywm
      stow
      tree
      unzip
      vim
      virtualbox
      vscode
      xclip
    ];
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.09"; # Did you read the comment?
}
