pkgs:
let
  callPackage = pkgs.lib.callPackageWith(custom // pkgs);
  p = import ../nixversions.nix {};
  custom = p // {
    hinclient = callPackage ./hinclient {};

    # Overriding
    i3lock-pixeled = callPackage ./i3lock-pixeled {};
    spectrwm = p.pkgsUnstable.spectrwm;
  };
in custom
