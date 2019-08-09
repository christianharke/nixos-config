# NixOS Configurations

## Usage

```bash
git clone git@github.com:christianharke/nixos-config.git
sudo ln -s $(pwd)/<server|workstation>/<env|role>/configuration.nix /etc/nixos/configuration.nix
sudo nixos-rebuild switch
```
