config:

let

  nixpkgs1903 = builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs-channels/archive/nixos-19.03.tar.gz";
    sha256 = "11z6ajj108fy2q5g8y4higlcaqncrbjm3dnv17pvif6avagw4mcb";
  };
  pkgs1903 = import nixpkgs1903 { config = config; };

  nixpkgs1909 = builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs-channels/archive/nixos-19.09.tar.gz";
    sha256 = "0hka65f31njqpq7i07l22z5rs7lkdfcl4pbqlmlsvnysb74ynyg1";
  };
  pkgs1909 = import nixpkgs1909 { config = config; };

in

{

  inherit pkgs1903;
  inherit pkgs1909;

}
