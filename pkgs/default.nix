pkgs:
let
  callPackage = pkgs.lib.callPackageWith(custom // pkgs);
  p = import ../nixversions.nix {};
  custom = p // {
    # Overriding
    spectrwm = callPackage ./spectrwm {};
  };
in custom
