# NixOS Configurations

## Usage

### Manual steps

#### WPA supplicant config

```bash
sudo su
cat > /etc/wpa_supplicant.conf << EOL
ctrl_interface=/run/wpa_supplicant
ctrl_interface_group=wheel
EOL
```

### Apply configuration

```bash
git clone git@github.com:christianharke/nixos-config.git
sudo ln -s $(pwd)/<server|workstation>/<env|role>/configuration.nix /etc/nixos/configuration.nix
sudo nixos-rebuild switch
```
