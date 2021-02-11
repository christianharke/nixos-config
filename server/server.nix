# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix

      # Include role configuration
      ../modules/container.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub = {
    enable = true;
    version = 2;
    # Define on which hard drive you want to install Grub.
    device = "/dev/sda";
  };

  networking.hostName = "nixos"; # Define your hostname.

  # Select internationalisation properties.
  i18n = {
  #   consoleFont = "Lat2-Terminus16";
  #   consoleKeyMap = "en";
    defaultLocale = "de_CH.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "Europe/Zurich";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    git
  ];

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Enable VMware Tools
  services.vmwareGuest = {
    enable = true;
    headless = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.christian = {
    isNormalUser = true;
    uid = 1000;
    initialPassword = "changeme";
    extraGroups = [ "wheel" ];
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCxWxGVejEPm83DEMaNxuhGTCsHAV3Peoa/kkp+/89ufZ/jYIwPhIZsOz6DG+1k42BE0N8gMKO1Bg5AYt/jEDpFxlchYkKOKCGkzFA3pjYHB6Saser9Jd9wVK5n+Dx1c+Pyfpr7pDZbHtq1WcNsUMw3FZxbg4W/CXoR/4dILEW3LiJVsZ16SB3qV5qg27xVts2ux7lbE9VjYg4XPQhmPRWWHZ0SwIb2JvUw+jTFnUJEPzinwV0EMH8tw7rQYKn6GP8ZtWqR6BJZH5gPJgJXFzdGztZ1rTQXZJeEb++KoBxVAXujsRaGSswJiGXd8dagxMarYqrzu4kFlUXjEbsxm+wTyq1LO2S8AcYG/xWP3YpoqDJMbbkvbOdXApQk0KM1BShZQxliRl3lTGV6GZQEIdXGJl5qQgDZHtbjL9pYBZGaXjnFi/aLl7r5H6ygEj0mjvscJqiJkw4xwrOvMj4I11pRttnyRzofx5995GtdTHQzwYcEqsz1Jf2+cZxKe2rjqHwOixwD3QIvJpUzX2Z5e9gmHU2Dbkcbtb6YyJUvwVH4gzz8SBbnSMZtP03nI3lUVtLgwxUobNOaGrpOOqdnB3nFec2eXFXPnJRzn8GiXEuQm8viApDdxi2GR6kqxblRFr9tIK+uefrJbaMZPGONCO/6DPmf7ZlJ8pgZ+0r/DV6bww==
ch.harke@gmail.com"
    ];
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.09"; # Did you read the comment?

  # Keep the system up-to-date
  system.autoUpgrade.enable = true;
}
