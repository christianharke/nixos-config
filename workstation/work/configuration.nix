{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware/default.nix
      ./projects/blueconnect.nix
      ./projects/multimed.nix
      ../../modules/common.nix
      ../../modules/desktop.nix
      ../../modules/docker.nix
      ../../modules/id.nix
      ../../modules/input.nix
      ../../modules/network.nix
      ../../modules/printing.nix
      ../../modules/redshift.nix
      ../../modules/sound.nix
      ../../modules/user.nix
      ../../modules/virtualbox.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "n75";

  fileSystems =
  let
    target = "/mnt/bluecare";
    fileserver = "bluecare-s54";
    fsType = "cifs";
    credentials = "/home/christian/.accounts/bluecare/smbcredentials";
    automount_opts = [ "x-systemd.automount" "noauto" "x-systemd.idle-timeout=60" "x-systemd.device-timeout=5s" "x-systemd.mount-timeout=5s" ];
    auth_opts = [ "uid=1000" "gid=100" "credentials=${credentials}" ];
    options = automount_opts ++ auth_opts;
  in
  {
    "${target}/home" = {
      device = "//${fileserver}/homeshares$/chr";
      fsType = fsType;
      options = options;
    };

    "${target}/bc_projekte" = {
      device = "//${fileserver}/bc_projekte$";
      fsType = fsType;
      options = options;
    };

    "${target}/bc_bereiche" = {
      device = "//${fileserver}/bc_bereiche$";
      fsType = fsType;
      options = options;
    };

    "${target}/ressourcenplanung" = {
      device = "//${fileserver}/bc_fuehrung$/04a_Fuehrungskader/03_Ressourcenplanung/Public";
      fsType = fsType;
      options = options;
    };

    "${target}/transfer" = {
      device = "//${fileserver}/transfer";
      fsType = fsType;
      options = options;
    };
  };

  environment = {
    systemPackages = with pkgs; [
      docker-ls
      khal
      khard
      mutt-with-sidebar
      offlineimap
      openshift
      urlview
      vdirsyncer
      w3m
      zoom-us
    ];
    variables = {
      JAVA_HOME = "${pkgs.openjdk}/lib/openjdk";
      JDK_HOME = "${pkgs.openjdk}/lib/openjdk";
    };
  };

  services = {
    davmail = {
      enable = true;
      url = "https://mail.bluecare.ch/owa";
      config = {
       davmail.server = true;
       davmail.mode = "EWS";
       davmail.caldavPort = 1080;
       davmail.imapPort = 1143;
       davmail.smtpPort = 1025;
       davmail.disableUpdateCheck = true;
       davmail.logFilePath = "/var/log/davmail/davmail.log";
       davmail.logFileSize = "1MB";
       log4j.logger.davmail = "WARN";
       log4j.logger.httpclient.wire = "WARN";
       log4j.logger.org.apache.commons.httpclient = "WARN";
       log4j.rootLogger = "WARN";
      };
    };

    openvpn.servers.bluecare = {
      autoStart = false;
      config = "config /home/christian/.accounts/bluecare/ovpn/chr@vpfwblue.bluecare.ch.ovpn";
      updateResolvConf = true;
    };

    xserver.dpi = 96;
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.03"; # Did you read the comment?

}
