{ config, pkgs, ... }:

{
  networking.firewall = {
      enable = true;
      allowPing = true;
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
}
