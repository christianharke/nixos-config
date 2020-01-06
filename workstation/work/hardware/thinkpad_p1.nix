{ config, lib, pkgs, ... }:

let

  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };

in

{

  boot.kernelPackages = unstable.pkgs.linuxPackages_5_3;

  hardware.enableRedistributableFirmware = true;

  nix.maxJobs = lib.mkOverride 20 6;

  services.xserver.videoDrivers = [
    "nvidia"
    "displaylink"
  ];

}
