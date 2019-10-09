{ config, pkgs, ... }:

{

  containers.mongodb.config =
    { config, pkgs, ... }:
    {
      services.mongodb.enable = true;
    };

  environment.systemPackages = with pkgs; [
    ansible
    chromedriver
    geckodriver
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
