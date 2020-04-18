{ config, pkgs, ... }:

let

  user = config.users.users.christian.name;

in

{
  environment.systemPackages = [ pkgs.nextcloud-client ];

  systemd.user.services.nextcloud-client = {
    description = "Nextcloud Client for account ${user}";
    documentation = [ "https://docs.nextcloud.com/#desktop" ];
    wantedBy = [ "default.target" ];
    serviceConfig = {
      ConditionUser = user;
      Type = "simple";
      ExecStart = "${pkgs.nextcloud-client}/bin/nextcloud --background";
      ExecReload = "${pkgs.coreutils}/bin/kill -HUP $MAINPID";
      KillMode = "process";
      Restart = "on-failure";
    };
  };
}
