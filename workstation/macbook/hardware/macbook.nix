{ config, lib, pkgs, ... }:

{
  imports = [
    <nixos-hardware/apple/macbook-pro/10-1>
  ];

  services.xserver = {
      xkbModel = "apple";
      xkbVariant = "de_mac";
      xkbOptions = "caps:swapescape";
  };

  nix.maxJobs = lib.mkOverride 20 4;

  powerManagement.enable = true;
}
