{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    docker-compose
    docker-ls
  ];

  virtualisation.docker = {
    enable = true;
    enableOnBoot = false;
  };

  users.users.christian.extraGroups = [ "docker" ];
}
