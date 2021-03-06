{ pkgs, config, ... }:

let

  username = "christian";
  keyFile = /. + "/home/${username}/.ssh/id_rsa.pub";

in

{
  programs = {
      vim.defaultEditor = true;
      zsh.enable = true;
  };

  users.users.${username} = {
    name = username;
    isNormalUser = true;
    uid = 1000;
    extraGroups = [
      "wheel" "audio" "video" "scanner"
    ];
    initialPassword = "changeme";
    openssh.authorizedKeys.keyFiles = [ keyFile ];
    shell = pkgs.zsh;
  };
}
