{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware
      ../../modules/common
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "altair";

  software.dev = [];

  services.xserver = {
    displayManager.lightdm.greeters.mini = {
      enable = true;
      user = "christian";
    };
    xkbOptions = "caps:escape";
  };
}
