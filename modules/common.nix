{ config, pkgs, ... }:

{
  time.timeZone = "Europe/Zurich";

  nixpkgs.config.allowUnfree = true;

  environment = {
    variables = {
      EDITOR = "vim";
    };
  };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
}
