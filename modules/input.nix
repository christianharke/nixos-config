{ config, pkgs, ... }:

{
  # Touchpad settings
  services.xserver.libinput = {
    enable = true;
    naturalScrolling = true;
    disableWhileTyping = true;
    sendEventsMode = "disabled-on-external-mouse";
  };
}
