{ config, pkgs, ... }:

{
  time.timeZone = "Europe/Zurich";

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
    automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
    credentials = "/home/christian/.smbcredentials/home";
  in
  {
    "${target}/home" = {
      device = "//${fileserver}/home";
      fsType = "cifs";
      options = ["${automount_opts},credentials=${credentials}"];
    };

    "${target}/music" = {
      device = "//${fileserver}/music";
      fsType = "cifs";
      options = ["${automount_opts},credentials=${credentials}"];
    };

    "${target}/photo" = {
      device = "//${fileserver}/photo";
      fsType = "cifs";
      options = ["${automount_opts},credentials=${credentials}"];
    };

    "${target}/public" = {
      device = "//${fileserver}/public";
      fsType = "cifs";
      options = ["${automount_opts},credentials=${credentials}"];
    };

    "${target}/video" = {
      device = "//${fileserver}/video";
      fsType = "cifs";
      options = ["${automount_opts},credentials=${credentials}"];
    };
  };
}
