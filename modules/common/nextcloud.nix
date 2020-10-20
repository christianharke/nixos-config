{ config, pkgs, ... }:

let

  v = import ../../nixversions.nix {};
  nextcloud = v.pkgsUnstable.nextcloud-client;

in

{
  environment.systemPackages = [ nextcloud ];

  systemd.user.services.nextcloud-client = {
    description = "Nextcloud Client";
    documentation = [ "https://docs.nextcloud.com/#desktop" ];
    wantedBy = [ "default.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${nextcloud}/bin/nextcloud --background";
      ExecReload = "${pkgs.coreutils}/bin/kill -HUP $MAINPID";
      KillMode = "process";
      Restart = "on-failure";
    };
  };
}
