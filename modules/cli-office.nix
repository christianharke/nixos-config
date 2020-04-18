{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    khal khard vdirsyncer
    mutt-with-sidebar offlineimap urlview w3m
  ];

  systemd.user = {
    services = {

      offlineimap-oneshot = {
        description = "Offlineimap Service (oneshot)";
        documentation = [ "man:offlineimap(1)" ];
        wantedBy = [ "mail.target" ];
        serviceConfig = {
          Type = "oneshot";
          ExecStart = "${pkgs.offlineimap}/bin/offlineimap -o -u basic";
          TimeoutStopSec = "2m";
        };
      };

      vdirsyncer-oneshot = {
        description = "Synchronize calendars and contacts (oneshot)";
        documentation = [ "https://vdirsyncer.readthedocs.org/" ];
        serviceConfig = {
          Type = "oneshot";
          ExecStart = "${pkgs.vdirsyncer}/bin/vdirsyncer sync";
        };
      };
    };

    timers = {

      offlineimap-oneshot = {
        description = "Offlineimap Query Timer";
        wantedBy = [ "timers.target" ];
        timerConfig = {
          OnBootSec = "1m";
          OnUnitInactiveSec = "15m";
        };
      };

      vdirsyncer-oneshot = {
        description = "Synchronize vdirs";
        wantedBy = [ "timers.target" ];
        timerConfig = {
          OnBootSec = "5m";
          OnUnitActiveSec = "15m";
          AccuracySec = "5m";
        };
      };
    };
  };
}
