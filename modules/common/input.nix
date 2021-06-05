{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    numlockx
    xbindkeys
  ];

  services.xserver = {
    displayManager = {
      setupCommands = ''
        ${pkgs.numlockx}/bin/numlockx on
      '';
      sessionCommands = ''
        numlockx on
        xbindkeys
      '';
    };

    layout = "ch";

    # Touchpad settings
    libinput = {
      enable = true;
      touchpad = {
        naturalScrolling = true;
        disableWhileTyping = true;
        sendEventsMode = "disabled-on-external-mouse";
      };
    };
  };
}
