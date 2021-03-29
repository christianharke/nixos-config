{ config, pkgs, ... }:

with pkgs.lib;

{
  imports = import ../pkgs/modules.nix;

  options.software.gaming = mkOption {
    type = types.listOf types.package;
    default = with pkgs; [
      # Comms
      discord
      teamspeak_client

      # Game libs
      lutris

      # Games
      superTux
      superTuxKart
      wesnoth
      zeroad
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

