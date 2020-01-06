{ config, lib, pkgs, ... }:

{

  nix.maxJobs = lib.mkOverride 20 4;

  services.xserver.videoDrivers = [
    "nvidia"
  ];

  #boot.kernelPatches = [
    #{ name = "poweroff-fix"; patch = ./patches/kernel/poweroff-fix.patch; }
    #{ name = "hid-apple-keyboard"; patch = ./patches/kernel/hid-apple-keyboard.patch; }
  #];

  boot.kernelParams = [
    "hid_apple.fnmode=2"
    #"hid_apple.swap_fn_leftctrl=1"
  ];
  boot.extraModprobeConfig = ''
    options snd_hda_intel index=0 model=intel-mac-auto id=PCM
    options snd_hda_intel index=1 model=intel-mac-auto id=HDMI
    options snd_hda_intel model=mbp101
  '';

  hardware.facetimehd.enable = true;
  hardware.opengl.extraPackages = [ pkgs.vaapiIntel ];

  programs.light.enable = true;

  services.mbpfan = {
    enable = true;
    lowTemp = 61;
    highTemp = 64;
    maxTemp = 84;
  };

  powerManagement.enable = true;
  
}
