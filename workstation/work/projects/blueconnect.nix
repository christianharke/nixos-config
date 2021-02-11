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
}

