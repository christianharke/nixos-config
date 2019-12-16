{ config, pkgs, ... }:

{
  networking = {
    firewall = {
        enable = true;
        allowPing = true;
    };
    wireless.enable = true;
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
}
