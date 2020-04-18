{ config, pkgs, ... }:

{
  imports = import ../pkgs/modules.nix;

  nixpkgs = {
    config = {
      packageOverrides = import ../pkgs;
    };
  };
}
