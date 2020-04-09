{ config, pkgs, ... }:

{
  services.openvpn.servers.home = {
    autoStart = false;
    config = "config /home/christian/.accounts/home/ovpn/christian.ovpn";
    updateResolvConf = true;
  };
}

