{ config, pkgs, ... }:

{
  imports =
    [
      ../../../modules/java.nix
    ];

  environment.systemPackages = with pkgs; [
    jetbrains.idea-ultimate
    nodejs
    sbt
  ];
}

