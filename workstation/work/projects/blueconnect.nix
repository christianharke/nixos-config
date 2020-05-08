{ config, pkgs, ... }:

{

  imports =
    [
      ../../../modules/java.nix
    ];

  containers.mongodb.config =
    { config, pkgs, ... }:
    {
      nixpkgs.config.allowUnfree = true;
      services.mongodb.enable = true;
    };

  # E2E proxy server
  networking.firewall.allowedTCPPorts = [ 33000 ];

  environment.systemPackages = with pkgs; [
    ansible
    chromedriver
    geckodriver
    groovy
    htmlunit-driver
    jetbrains.idea-ultimate
    mongodb
    mongodb-tools
    nodePackages.grunt-cli
    robo3t
    sbt
    tesseract4
    vagrant
    zip
  ];
}

