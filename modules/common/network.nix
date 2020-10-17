{ config, pkgs, ... }:

{
  networking = {
    firewall = {
      enable = true;
      allowPing = true;
    };
    networkmanager.enable = true;
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
}
