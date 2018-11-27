{ config, pkgs, ... }:

{
  services.nfs.server.enable = true;
  services.nfs.exports = ''
    /       *(ro,fsid=0)
    /docker *(rw,no_root_squash,no_subtree_check,nohide)
  '';
  services.nfs.server.createMountPoints = true;
}
