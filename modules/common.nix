{ config, pkgs, ... }:

{
  time.timeZone = "Europe/Zurich";

  nixpkgs.config.allowUnfree = true;

  boot.cleanTmpDir = true;

  environment = {
    variables = {
      EDITOR = "vim";
      TERMINAL = "alacritty";
    };
  };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
}
