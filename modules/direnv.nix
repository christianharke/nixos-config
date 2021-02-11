{ pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      direnv
      nix-direnv
    ];
    pathsToLink = [
      "/share/nix-direnv"
    ];
  };

  nix.extraOptions = ''
    keep-outputs = true
    keep-derivations = true
  '';
}
