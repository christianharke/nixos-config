{ config, lib, pkgs, ... }:

{
  nix.maxJobs = lib.mkOverride 20 4;

  hardware.opengl.driSupport32Bit = true;
  services.xserver.videoDrivers = [
    "nvidia"
  ];
}
