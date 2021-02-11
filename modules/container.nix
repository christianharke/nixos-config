{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    docker-compose
    docker-ls
    lazydocker
  ];

  virtualisation.docker = {
    enable = true;
    enableOnBoot = false;
  };

  users.users.christian.extraGroups = [ "docker" ];
}
