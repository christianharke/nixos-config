{ config, pkgs, ... }:

{
  networking.firewall.allowedTCPPorts = [ 111 2049 20048 ];
  networking.firewall.allowedUDPPorts = [ 111 20048 ];

  services.nfs.server.enable = true;
  services.nfs.server.exports = ''
    /lan    172.16.0.0/16(rw,no_root_squash,no_subtree_check,nohide)
    /dmz    172.17.0.0/16(rw,no_root_squash,no_subtree_check,nohide)
  '';
  services.nfs.server.createMountPoints = true;
}
