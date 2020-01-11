{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
      ../../modules/common.nix
      ../../modules/desktop.nix
      ../../modules/docker.nix
      ../../modules/input.nix
      ../../modules/network.nix
      ../../modules/printing.nix
      ../../modules/redshift.nix
      ../../modules/software.nix
      ../../modules/sound.nix
      ../../modules/user.nix
      ../../modules/virtualbox.nix
    ];

  boot.loader.grub = {
    enable = true;
    version = 2;
    device = "/dev/sda"; # or "nodev" for efi only
  };

  networking.hostName = "nb-nixos-01";

  fonts.fonts = with pkgs; [
    google-fonts
  ];

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.09"; # Did you read the comment?
}
