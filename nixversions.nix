config:

let

  nixpkgs1903 = builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs-channels/archive/nixos-19.03.tar.gz";
    sha256 = "11z6ajj108fy2q5g8y4higlcaqncrbjm3dnv17pvif6avagw4mcb";
  };
  pkgs1903 = import nixpkgs1903 { config = { allowUnfree = true; }; };

  nixpkgs1909 = builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs-channels/archive/nixos-19.09.tar.gz";
    sha256 = "0hka65f31njqpq7i07l22z5rs7lkdfcl4pbqlmlsvnysb74ynyg1";
  };
  pkgs1909 = import nixpkgs1909 { config = { allowUnfree = true; }; };

  nixpkgsUnstable = builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs-channels/archive/nixos-unstable.tar.gz";
    sha256 = "14rvi69ji61x3z88vbn17rg5vxrnw2wbnanxb7y0qzyqrj7spapx";
  };
  pkgsUnstable = import nixpkgsUnstable { config = { allowUnfree = true; }; };

  nixpkgsMaster = builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/master.tar.gz";
    sha256 = "1dgchfy093v7nn7zqckaahbv2zb79b1wf66qzg15pxp5wn3xa9hc";
  };
  pkgsMaster = import nixpkgsMaster {
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [ "p7zip-16.02" ];
    };
  };

in

{

  inherit pkgs1903;
  inherit pkgs1909;
  inherit pkgsUnstable;
  inherit pkgsMaster;

}
