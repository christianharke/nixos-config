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
    ];
    initialPassword = "changeme";
    openssh.authorizedKeys.keyFiles = [ keyFile ];
    packages = with pkgs; [
      _1password
      alacritty
      bat
      bind
      convmv
      eva
      exa
      fd
      file
      firefox
      freerdp
      fzf
      gifski
      gimp
      git
      gnupg
      google-chrome
      gron
      htop
      jq
      id3lib
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
      ripgrep
      scrot
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
