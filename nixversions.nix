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
    sha256 = "14q3kvnmgz19pgwyq52gxx0cs90ddf24pnplmq33pdddbb6c51zn";
  };
  pkgsUnstable = import nixpkgsUnstable { config = { allowUnfree = true; }; };

  nixpkgsMaster = builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/master.tar.gz";
    sha256 = "1nrkrbix97fcvqgp00195bz262i0zb03l1c8ih7jrr0iq9ynw321";
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
