{ config, pkgs, ... }:

{
  # TODO: enable firewall
  networking = {
    wireless.enable = true;
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
}
