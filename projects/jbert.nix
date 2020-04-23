{ config, pkgs, ... }:

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
    micronaut
    mpc_cli
  ];
}

