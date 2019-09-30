{ pkgs, config, ... }:

{
  services.redshift = {
    enable = true;
    brightness.night = "0.8";
    temperature.night = 3500;
  };
}
