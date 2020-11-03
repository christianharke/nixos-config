{ config, pkgs, ... }:

with pkgs.lib;

{
  imports = import ../pkgs/modules.nix;

  options.software.gaming = mkOption {
    type = types.listOf types.package;
    default = with pkgs; [
      discord
      lutris
      teamspeak_client
    ];
  };

  config = {
    programs.steam.enable = true;

    hardware.xpadneo.enable = true;

    environment.systemPackages =
      let
        ff = p: ! builtins.elem p config.software.blacklist;
      in
        builtins.filter ff config.software.gaming;
  };
}

