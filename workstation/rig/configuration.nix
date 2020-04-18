{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware/default.nix
      ../../modules/common.nix
      ../../modules/desktop.nix
      ../../modules/id.nix
      ../../modules/input.nix
      ../../modules/java.nix
      ../../modules/network.nix
      ../../modules/nextcloud.nix
      ../../modules/printing.nix
      ../../modules/software.nix
      ../../modules/sound.nix
      ../../modules/user.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "altair";

  software.dev = [];

  services.xserver.xkbOptions = "caps:escape";

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.09"; # Did you read the comment?
}
