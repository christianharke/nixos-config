{ config, pkgs, ... }:

{
  nixpkgs = {
    config = {
      packageOverrides = import ../../pkgs;
    };
  };
}
