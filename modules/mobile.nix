{ config, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    acpi
    libnotify
  ];

  systemd.user = {
    services = {
      battery-check = {
        description = "Battery level notification";
        script = ''
          POWEROFF_THRESHOLD=3
          WARN_THRESHOLD=10
          DISCHARGING="$(${pkgs.acpi}/bin/acpi -b | head -n 1 | grep Discharging | wc -l)"

          export DISPLAY=:0

          BATTERY_LEVEL=$(${pkgs.acpi}/bin/acpi  -b | grep -P -o '[0-9]+(?=%)')

          if [ $BATTERY_LEVEL -le $POWEROFF_THRESHOLD -a $DISCHARGING = "1" ]
          then
              ${pkgs.libnotify}/bin/notify-send -u critical -t 60000 "Going to shutdown in 1 min!" "Battery level is $BATTERY_LEVEL%!"
              shutdown -h +1
          elif [ $BATTERY_LEVEL -le $WARN_THRESHOLD -a $DISCHARGING = "1" ]
          then
              ${pkgs.libnotify}/bin/notify-send -u critical -t 60000 "Battery low" "Battery level is $BATTERY_LEVEL%!"
          fi
        '';
      };
    };

    timers = {
      battery-check = {
        description = "Battery level notification timer";
        wantedBy = [ "timers.target" ];
        timerConfig = {
          OnBootSec = "1m";
          OnUnitInactiveSec = "1m";
        };
      };
    };
  };
}
