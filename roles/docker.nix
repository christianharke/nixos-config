{ config, pkgs, ... }:

{
  virtualisation.docker.enable = true;

  users.users.christian.extraGroups = [ "docker" ];
}
