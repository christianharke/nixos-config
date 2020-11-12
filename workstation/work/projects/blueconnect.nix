{ config, pkgs, ... }:

let

  v = import ../../../nixversions.nix {};

in

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
    ansible_2_8
    chromedriver
    geckodriver
    groovy
    htmlunit-driver
    jetbrains.idea-ultimate
    mongodb
    v.pkgs1903.mongodb-compass
    mongodb-tools
    nodejs-12_x
    nodePackages.grunt-cli
    robo3t
    sbt
    tesseract4
    v.pkgs2003.vagrant
    zip
  ];
}

