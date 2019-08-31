{ config, pkgs, ... }:

{

  imports = [
    # Include the results of the hardware scan.
    ./configuration.nix
    ./thinkpad_p1.nix
  ];

}
