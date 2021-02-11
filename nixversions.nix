config:

let

  nixpkgs1703 = builtins.fetchGit {
    url = "https://github.com/NixOS/nixpkgs.git";
    ref = "release-17.03";
  };
  pkgs1703 = import nixpkgs1703 { config = { allowUnfree = true; }; };

  nixpkgs1709 = builtins.fetchGit {
    url = "https://github.com/NixOS/nixpkgs.git";
    ref = "release-17.09";
  };
  pkgs1709 = import nixpkgs1709 { config = { allowUnfree = true; }; };

  nixpkgs1803 = builtins.fetchGit {
    url = "https://github.com/NixOS/nixpkgs.git";
    ref = "release-18.03";
  };
  pkgs1803 = import nixpkgs1803 { config = { allowUnfree = true; }; };

  nixpkgs1809 = builtins.fetchGit {
    url = "https://github.com/NixOS/nixpkgs.git";
    ref = "nixos-18.09";
  };
  pkgs1809 = import nixpkgs1809 { config = { allowUnfree = true; }; };

  nixpkgs1903 = builtins.fetchGit {
    url = "https://github.com/NixOS/nixpkgs.git";
    ref = "nixos-19.03";
  };
  pkgs1903 = import nixpkgs1903 { config = { allowUnfree = true; }; };

  nixpkgs1909 = builtins.fetchGit {
    url = "https://github.com/NixOS/nixpkgs.git";
    ref = "nixos-19.09";
  };
  pkgs1909 = import nixpkgs1909 { config = { allowUnfree = true; }; };

  nixpkgs2003 = builtins.fetchGit {
    url = "https://github.com/NixOS/nixpkgs.git";
    ref = "nixos-20.03";
  };
  pkgs2003 = import nixpkgs2003 { config = { allowUnfree = true; }; };

  nixpkgsUnstable = builtins.fetchGit {
    url = "https://github.com/NixOS/nixpkgs.git";
    ref = "nixos-unstable";
  };
  pkgsUnstable = import nixpkgsUnstable { config = { allowUnfree = true; }; };

  nixpkgsMaster = builtins.fetchGit {
    url = "https://github.com/NixOS/nixpkgs.git";
  };
  pkgsMaster = import nixpkgsMaster { config = { allowUnfree = true; }; };

in

{

  inherit pkgs1703;
  inherit pkgs1709;
  inherit pkgs1803;
  inherit pkgs1809;
  inherit pkgs1903;
  inherit pkgs1909;
  inherit pkgs2003;
  inherit pkgsUnstable;
  inherit pkgsMaster;

}
