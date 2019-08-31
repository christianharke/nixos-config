{ config, lib, pkgs, ... }:

{

  boot.kernelPackages = pkgs.linuxPackages_5_2;

  hardware.enableRedistributableFirmware = true;

  nix.maxJobs = lib.mkOverride 20 6;

  services.xserver.videoDrivers = [
    "nvidia"
    # "displaylink" # not working in 19.03
  ];

}
