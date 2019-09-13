# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

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

  fonts.fonts = with pkgs; [
    nerdfonts
    ubuntu_font_family
  ];

  fileSystems =
  let
    target = "/mnt/bluecare";
    fileserver = "bluecare-s54";
    automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s,uid=1000,gid=100";
    credentials = "/home/christian/.smbcredentials/bluecare";
  in
  {
    "${target}/home" = {
      device = "//${fileserver}/homeshares$/chr";
      fsType = "cifs";
      options = ["${automount_opts},credentials=${credentials}"];
    };

    "${target}/bc_projekte" = {
      device = "//${fileserver}/bc_projekte$";
      fsType = "cifs";
      options = ["${automount_opts},credentials=${credentials}"];
    };
  };

  environment = {
    variables = {
      JAVA_HOME = "${pkgs.openjdk}/lib/openjdk";
      JDK_HOME = "${pkgs.openjdk}/lib/openjdk";
    };
  };

  services.openvpn.servers.bluecare = {
    autoStart = false;
    config = "config /home/christian/.ovpn/chr@vpfwblue.bluecare.ch.ovpn";
    updateResolvConf = true;
  };

  services.xserver.dpi = 96;

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.03"; # Did you read the comment?

}
