{ config, lib, pkgs, ... }:

{
  imports = [
    <nixos-hardware/apple/macbook-pro/10-1>
  ];

  nix.maxJobs = lib.mkOverride 20 4;

  powerManagement.enable = true;
}
