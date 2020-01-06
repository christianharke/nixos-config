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
    packages = with pkgs; [
      _1password
      alacritty
      bat
      bind
      convmv
      unstable.eva
      exa
      fd
      file
      firefox
      freerdp
      fzf
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
      lnav
      unstable.mdcat
      mupdf
      neofetch
      nixops
      peek gifski
      pinentry
      plantuml graphviz
      ranger
      ripgrep
      scrot
      slack
      spotifywm
      stow
      thunderbird
      tmux
      tmuxinator
      tree
      unzip
      vscode
      xclip
      xorg.xbacklight

      # REPLs
      ammonite # Scala
      python3
      spidermonkey # JS
    ];
  };

  security.pam.enableSSHAgentAuth = true;
}
