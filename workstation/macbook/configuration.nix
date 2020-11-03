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
    extra = with pkgs; [
      dropbox-cli
    ];
  };
}
