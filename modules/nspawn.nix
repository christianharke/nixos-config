{ pkgs, config, ... }:

{
  environment.systemPackages = [ pkgs.debootstrap ];
  systemd.nspawn.debian.enable = true;
}
