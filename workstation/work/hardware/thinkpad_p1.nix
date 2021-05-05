{ config, lib, pkgs, ... }:

{

  environment = {
    systemPackages = [
      pkgs.xorg.xbacklight
    ];
    variables = {
      WINIT_X11_SCALE_FACTOR = "1";
    };
  };

  hardware = {
    cpu.intel.updateMicrocode = true;
    enableRedistributableFirmware = true;
  };

  networking.wireless.enable = true;

  nix.maxJobs = lib.mkOverride 20 6;

  services = {
    logind.lidSwitch = "suspend-then-hibernate";

    xserver = {
      dpi = 96;
      videoDrivers = [
        "nvidia"
      ];
    };
  };

}
