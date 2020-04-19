{ config, pkgs, ... }:

{
  environment.systemPackages = [ pkgs.nextcloud-client ];

  systemd.user.services.nextcloud-client = {
    description = "Nextcloud Client";
    documentation = [ "https://docs.nextcloud.com/#desktop" ];
    wantedBy = [ "default.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.nextcloud-client}/bin/nextcloud --background";
      ExecReload = "${pkgs.coreutils}/bin/kill -HUP $MAINPID";
      KillMode = "process";
      Restart = "on-failure";
    };
  };
}
