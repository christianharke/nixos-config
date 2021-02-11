{ config, pkgs, ... }:

let

  acc = config.accounts."bluecare/ad";

in

{
  imports =
    [
      ./hardware
      ../../modules/cli-office.nix
      ../../modules/common
      ../../modules/container.nix
      ../../modules/direnv.nix
      ../../modules/java.nix
      ../../projects/jbert.nix
      ./hinclient.nix
    ] ++ import ./projects;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "n75";

  fileSystems =
  let
    target = "/mnt/bluecare";
    fileserver = "bluecare-s54";
    fsType = "cifs";
    credentials = "/home/christian/.accounts/bluecare/smbcredentials";
    automount_opts = [ "x-systemd.automount" "noauto" "x-systemd.idle-timeout=60" "x-systemd.device-timeout=5s" "x-systemd.mount-timeout=5s" ];
    auth_opts = [ "uid=1000" "gid=100" "credentials=${credentials}" ];
    options = automount_opts ++ auth_opts;
  in
  {
    "${target}/home" = {
      device = "//${fileserver}/homeshares$/chr";
      fsType = fsType;
      options = options;
    };

    "${target}/bc_projekte" = {
      device = "//${fileserver}/bc_projekte$";
      fsType = fsType;
      options = options;
    };

    "${target}/bc_bereiche" = {
      device = "//${fileserver}/bc_bereiche$";
      fsType = fsType;
      options = options;
    };

    "${target}/bluecare" = {
      device = "//${fileserver}/bluecare$";
      fsType = fsType;
      options = options;
    };

    "${target}/transfer" = {
      device = "//${fileserver}/transfer";
      fsType = fsType;
      options = options;
    };
  };

  hardware.printers =
  let
    credentials = "${acc.domain}\\${acc.username}:${acc.password}";
    printserver = "bluecare-s20";
    location = "BlueCare";
    description = "Kyocera TASKalfa 300ci";
    model = "Kyocera/Kyocera_TASKalfa_300ci.ppd";
  in
  {
    ensurePrinters = [
      {
        name = "FollowMe";
        location = location;
        description = description;
        deviceUri = "smb://${credentials}@${printserver}/FollowMe";
        model = model;
      }
      {
        name = "FollowMe_Color";
        location = location;
        description = "${description} Color";
        deviceUri = "smb://${credentials}@${printserver}/FollowMe%20Color";
        model = model;
      }
    ];
    ensureDefaultPrinter = "FollowMe";
  };

  software = {
    extra = with pkgs; [
      freerdp
      lutris
      openshift
      slack
      teams
      zoom-us
    ];
  };

  services = {
    davmail = {
      enable = true;
      url = "https://mail.bluecare.ch/owa";
      config = {
       davmail.server = true;
       davmail.mode = "EWS";
       davmail.caldavPort = 1080;
       davmail.imapPort = 1143;
       davmail.smtpPort = 1025;
       davmail.disableUpdateCheck = true;
       davmail.logFilePath = "/var/log/davmail/davmail.log";
       davmail.logFileSize = "1MB";
       log4j.logger.davmail = "WARN";
       log4j.logger.httpclient.wire = "WARN";
       log4j.logger.org.apache.commons.httpclient = "WARN";
       log4j.rootLogger = "WARN";
      };
    };

    openvpn.servers.bluecare = {
      autoStart = false;
      config = "config /home/christian/.accounts/bluecare/ovpn/chr@vpfwblue.bluecare.ch.ovpn";
      updateResolvConf = true;
    };

    printing.drivers = [ pkgs.cups-kyodialog3 ];

    xserver = {
      displayManager.lightdm.greeters.mini = {
        enable = true;
        user = "christian";
      };
      xkbOptions = "caps:swapescape";
    };
  };

  containers.devmail =
  { config = { config, pkgs, ... }:
      { imports = [ ../../modules/devmail.nix ];
        services.devmail = {
          enable = true;
          primaryHostname = "devmail";
          localDomains = [ "hin.ch" "test.com" ];
        };
      };
    privateNetwork = true;
    hostAddress = "10.231.2.1";
    localAddress = "10.231.2.2";
    autoStart = false;
  };
  networking.extraHosts = ''
    10.231.2.2 devmail
  '';
}
