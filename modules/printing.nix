{ config, pkgs, ...}:

{
  services.printing = {
    enable = true;
    drivers = [ pkgs.hplipWithPlugin ];
  };
  environment.systemPackages = [
    pkgs.unpaper
  ];
}
