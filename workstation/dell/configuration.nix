{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
      ../../modules/common
    ];

  boot.loader.grub = {
    enable = true;
    version = 2;
    device = "/dev/sda"; # or "nodev" for efi only
  };

  networking = {
    hostName = "nb-nixos-01";
    wireless.enable = true;
  }

  services.xserver.xkbOptions = "caps:swapescape";

  fonts.fonts = with pkgs; [
    google-fonts
  ];
}
