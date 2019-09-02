{ pkgs, config, ... }:

let
  keyFile = builtins.toPath /home/christian/.ssh/id_rsa.pub;
  username = "christian";

in

{
  users.users.${username} = {
    isNormalUser = true;
    uid = 1000;
    extraGroups = [
      "wheel"
      "vboxusers"
    ];
    initialPassword = "changeme";
    openssh.authorizedKeys.keyFiles = [ keyFile ];
    packages = with pkgs; [
      _1password
      bat
      bind
      file
      firefox
      gimp
      git
      gnupg
      google-chrome
      htop
      jq
      killall
      lazydocker
      lazygit
      libreoffice
      mupdf
      neofetch
      nixops
      peek
      pinentry
      ranger
      rxvt_unicode
      screenfetch
      rdesktop
      slack
      spotifywm
      stow
      tmux
      tmuxinator
      tree
      unzip
      vim
      vscode
      xclip
      xorg.xbacklight
    ];
  };

  security.pam.enableSSHAgentAuth = true;
}
