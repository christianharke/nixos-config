{ config, pkgs, ... }:

{
  time.timeZone = "Europe/Zurich";

  nixpkgs.config.allowUnfree = true;

  boot.cleanTmpDir = true;

  environment = let
    terminal = "alacritty";
  in {
    variables = {
      EDITOR = "vim";
      TERMINAL = terminal;
      TERMCMD = terminal;
    };
  };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
}
