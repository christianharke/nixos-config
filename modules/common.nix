{ config, pkgs, ... }:

{
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

  boot.cleanTmpDir = true;

  environment = let
    terminal = "alacritty";
  in {
    variables = {
      EDITOR = "vim";
      TERMINAL = terminal;
      TERMCMD = terminal;
    };
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
}
