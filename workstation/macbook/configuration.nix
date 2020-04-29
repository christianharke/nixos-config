{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware
      ../../modules/common
      ../../modules/docker.nix
      ../../modules/java.nix
      ../../modules/nspawn.nix
      ../../projects/jbert.nix
    ];

  networking.hostName = "beteigeuze";

  fonts.fonts = with pkgs; [
    google-fonts
  ];

  services.xserver.xkbOptions = "caps:swapescape";

  software = {
    gaming = [];
    extra = with pkgs; [
      dropbox-cli
    ];
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.09"; # Did you read the comment?
}
