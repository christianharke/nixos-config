{ pkgs, config, ... }:

let

  unstable = import <nixos-unstable> {};
  keyFile = builtins.toPath /home/christian/.ssh/id_rsa.pub;
  username = "christian";

in

{
  programs = {
      vim.defaultEditor = true;
      zsh.enable = true;
  };

  users.users.${username} = {
    isNormalUser = true;
    uid = 1000;
    extraGroups = [
      "wheel"
    ];
    initialPassword = "changeme";
    openssh.authorizedKeys.keyFiles = [ keyFile ];
    shell = pkgs.zsh;
  };

  security.pam.enableSSHAgentAuth = true;
}
