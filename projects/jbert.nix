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
}

