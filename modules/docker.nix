{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    docker-compose
  ];

  virtualisation.docker = {
    enable = true;
    enableOnBoot = false;
  };

  users.users.christian.extraGroups = [ "docker" ];
}
