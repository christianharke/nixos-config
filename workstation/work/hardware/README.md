# DisplayLink Setup

## Drivers Installation

### Add Kernel Module

```nix
{
  services.xserver.videoDrivers = [ "displaylink" ];
}
```

### Put DisplayLink into the Nix Store

Run `nixos-rebuild` and follow the instructions of the DisplayLink drivers installer.

As a reference, it is more or less like this:

```bash
# Download http://www.displaylink.com/downloads/file?id=1261 and store it as displaylink.zip
nix-prefetch-url file://$PWD/displaylink.zip
```

Run `nixos-rebuild` again (now it should succeed).

## Setup Monitors

```bash
# xrandr --listproviders
xrandr --setprovideroutputsource 1 0
xrandr --setprovideroutputsource 2 0
# xrandr --query (now the monitors should be detected)
xrandr --output DP-2 --auto --output DVI-I-1-1 --auto --right-of DP-2 --output DVI-I-2-2 --auto --right-of DVI-I-1-1
```
