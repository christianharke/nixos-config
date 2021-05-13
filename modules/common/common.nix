{ config, pkgs, ... }:

let

  localeLang = "en_US.UTF-8";
  localeFormats = "de_CH.UTF-8";

in

{
  i18n = {
    defaultLocale = localeLang;
    extraLocaleSettings = {
      LC_NUMERIC = localeFormats;
      LC_TIME = localeFormats;
      LC_MONETARY = localeFormats;
      LC_PAPER = localeFormats;
      LC_MEASUREMENT = localeFormats;
    };
  };

  location = {
    latitude = 47.5;
    longitude = 8.75;
  };

  time.timeZone = "Europe/Zurich";

  nix.gc = {
    automatic = true;
    dates = "04:00";
    options = "--delete-older-than 7d";
  };

  nixpkgs.config.allowUnfree = true;

  boot = {
    cleanTmpDir = true;
    extraModulePackages = [ config.boot.kernelPackages.exfat-nofuse ];
  };

  security.sudo.extraConfig = ''
    Defaults insults
  '';

  environment = let
    terminal = "alacritty";
  in {
    homeBinInPath = true;
    variables = {
      TERMINAL = terminal;
      TERMCMD = terminal;
    };
  };

  fonts = {
    fonts = with pkgs; [
      corefonts
      google-fonts
    ];
    enableFontDir = true;
  };

  fileSystems =
  let
    target = "/mnt/home";
    fileserver = "sv-syno-01";
    fsType = "cifs";
    credentials = "/home/christian/.accounts/home/smbcredentials";
    automount_opts = [ "x-systemd.automount" "noauto" "x-systemd.idle-timeout=60" "x-systemd.device-timeout=5s" "x-systemd.mount-timeout=5s" ];
    auth_opts = [ "uid=1000" "gid=100" "credentials=${credentials}" ];
    options = automount_opts ++ auth_opts;
  in
  {
    "${target}/backup" = {
      device = "//${fileserver}/backup";
      fsType = fsType;
      options = options;
    };

    "${target}/home" = {
      device = "//${fileserver}/home";
      fsType = fsType;
      options = options;
    };

    "${target}/music" = {
      device = "//${fileserver}/music";
      fsType = fsType;
      options = options;
    };

    "${target}/photo" = {
      device = "//${fileserver}/photo";
      fsType = fsType;
      options = options;
    };

    "${target}/public" = {
      device = "//${fileserver}/public";
      fsType = fsType;
      options = options;
    };

    "${target}/video" = {
      device = "//${fileserver}/video";
      fsType = fsType;
      options = options;
    };
  };

  system = {
    autoUpgrade = {
      enable = true;
      allowReboot = false;
      channel = https://nixos.org/channels/nixos-20.09;
    };
    # This value determines the NixOS release with which your system is to be
    # compatible, in order to avoid breaking some software such as database
    # servers. You should change this only after NixOS release notes say you
    # should.
    stateVersion = "20.03"; # Did you read the comment?
  };
}
