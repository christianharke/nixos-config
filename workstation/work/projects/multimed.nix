{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    jetbrains.idea-ultimate
    nodejs
    openjdk
    sbt
  ];
}
