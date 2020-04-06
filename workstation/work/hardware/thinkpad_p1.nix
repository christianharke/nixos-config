{ config, lib, pkgs, ... }:

{

  boot.kernelPackages = pkgs.linuxPackages_latest;

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
      #"displaylink"
    ];
  };

}
