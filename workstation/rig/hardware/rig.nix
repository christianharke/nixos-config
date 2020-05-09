{ config, lib, pkgs, ... }:

{
  nix.maxJobs = lib.mkOverride 20 4;

  hardware = {
    cpu.intel.updateMicrocode = true;
    enableRedistributableFirmware = true;
    opengl.driSupport32Bit = true;
  };

  services.xserver.videoDrivers = [
    "nvidia"
  ];
}
