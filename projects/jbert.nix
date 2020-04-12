{ config, pkgs, ... }:

let

  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };

in

{
  imports =
    [
      ../modules/java.nix
    ];

  services.mpd = {
    enable = true;
    dataDir = "/tmp/jbert";
    group = "audio";
  };

  users.users.christian.extraGroups = [
    "audio"
  ];

  environment.systemPackages = with pkgs; [
    ansible
    cantata
    gradle
    jetbrains.idea-ultimate
    mpc_cli
    unstable.micronaut
  ];
}

