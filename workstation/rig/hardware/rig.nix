{ config, lib, pkgs, ... }:

{
  nix.maxJobs = lib.mkOverride 20 4;

  hardware = {
    cpu.intel.updateMicrocode = true;
    enableRedistributableFirmware = true;
  };

  services.xserver = {
    dpi = 96;
    videoDrivers = [
      "nvidia"
    ];
  };
}
