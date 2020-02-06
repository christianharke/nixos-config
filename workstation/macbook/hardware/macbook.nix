{ config, lib, pkgs, ... }:

{
  imports = [
    <nixos-hardware/apple/macbook-pro/10-1>
  ];

  boot.kernelParams = [
    "hid_apple.fnmode=2"
  ];

  services.xserver = {
    dpi = 150;
    xkbModel = "apple";
    xkbVariant = "de_mac";
  };

  nix.maxJobs = lib.mkOverride 20 4;

  powerManagement.enable = true;
}
