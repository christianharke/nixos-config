{ config, lib, pkgs, ... }:

let

  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };

in

{

  boot.kernelPackages = unstable.pkgs.linuxPackages_5_3;

  software.extra = [
    pkgs.xorg.xbacklight
  ];

  hardware = {
    cpu.intel.updateMicrocode = true;
    enableRedistributableFirmware = true;
  };

  networking.wireless.enable = true;

  nix.maxJobs = lib.mkOverride 20 6;

  services.xserver = {
    dpi = 96;
    videoDrivers = [
      "nvidia"
      "displaylink"
    ];
  };

}
