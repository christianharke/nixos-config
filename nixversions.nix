config:

let

  nixpkgs1703 = builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs-channels/archive/nixos-17.03.tar.gz";
    sha256 = "09f50jaijvry9lrnx891qmcf92yb8qs64n1cvy0db2yjrmxsxyw8";
  };
  pkgs1703 = import nixpkgs1703 { config = { allowUnfree = true; }; };

  nixpkgs1709 = builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs-channels/archive/nixos-17.09.tar.gz";
    sha256 = "1wn7nmb1cqfk2j91l3rwc6yhimfkzxprb8wknw5wi57yhq9m6lv1";
  };
  pkgs1709 = import nixpkgs1709 { config = { allowUnfree = true; }; };

  nixpkgs1803 = builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs-channels/archive/nixos-18.03.tar.gz";
    sha256 = "0d9pkbax0phh392j6pzkn365wbsgd0h1cmm58rwq8zf9lb0pgkg2";
  };
  pkgs1803 = import nixpkgs1803 { config = { allowUnfree = true; }; };

  nixpkgs1809 = builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs-channels/archive/nixos-18.09.tar.gz";
    sha256 = "157c64220lf825ll4c0cxsdwg7cxqdx4z559fdp7kpz0g6p8fhh2";
  };
  pkgs1809 = import nixpkgs1809 { config = { allowUnfree = true; }; };

  nixpkgs1903 = builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs-channels/archive/nixos-19.03.tar.gz";
    sha256 = "11z6ajj108fy2q5g8y4higlcaqncrbjm3dnv17pvif6avagw4mcb";
  };
  pkgs1903 = import nixpkgs1903 { config = { allowUnfree = true; }; };

  nixpkgs1909 = builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs-channels/archive/nixos-19.09.tar.gz";
    sha256 = "157c64220lf825ll4c0cxsdwg7cxqdx4z559fdp7kpz0g6p8fhhr";
  };
  pkgs1909 = import nixpkgs1909 { config = { allowUnfree = true; }; };

  nixpkgs2003 = builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs-channels/archive/nixos-20.03.tar.gz";
    sha256 = "0zi54vbfi6i6i5hdd4v0l144y1c8rg6hq6818jjbbcnm182ygyfa";
  };
  pkgs2003 = import nixpkgs2003 { config = { allowUnfree = true; }; };

  nixpkgsUnstable = builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs-channels/archive/nixos-unstable.tar.gz";
    sha256 = "0ww70kl08rpcsxb9xdx8m48vz41dpss4hh3vvsmswll35l158x0v";
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
