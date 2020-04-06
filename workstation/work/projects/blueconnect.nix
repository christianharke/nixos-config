{ config, pkgs, ... }:

let

  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };

in

{

  containers.mongodb.config =
    { config, pkgs, ... }:
    {
      services.mongodb.enable = true;
    };

  # E2E proxy server
  networking.firewall.allowedTCPPorts = [ 33000 ];

  environment.systemPackages = with pkgs; [
    ansible
    unstable.chromedriver
    geckodriver
    groovy
    htmlunit-driver
    jetbrains.idea-ultimate
    mongodb
    mongodb-tools
    nodePackages.grunt-cli
    openjdk
    robo3t
    sbt
    tesseract4
  ];

}
