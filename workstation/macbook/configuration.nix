{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware/default.nix
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

  networking.hostName = "beteigeuze";

  fonts.fonts = with pkgs; [
    google-fonts
  ];

  hardware.brightnessctl.enable = true;
  environment.systemPackages = with pkgs; [
    acpilight
  ];

  services.xserver.dpi = 150;

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.09"; # Did you read the comment?
}
