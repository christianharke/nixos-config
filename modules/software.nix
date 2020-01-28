{ config, pkgs, ... }:

with pkgs.lib;

let

  v = import ../nixversions.nix {};
  unstable = import <nixos-unstable> {};

in

{

  options.software = {

    common = mkOption {
      type = types.listOf types.package;
      default = with pkgs; [
        _1password
        bat
        bind
        convmv
        unstable.eva
        exa
        fd # ultra-fast find
        file
        fzf # fuzzy find
        git
        gnupg
        gron
        htop
        jq
        killall
        lazygit
        neofetch
        ranger
        stow
        unzip
        (vim_configurable.customize {
          name = "vim";
          vimrcConfig = {
            packages.myplugins = with pkgs.vimPlugins; {
              start = [ vim-nix ]; # load plugin on startup
            };
            customRC = ''
              " Save 1,000 items in history
              set history=1000

              " Show the line and column number of the cursor position
              set ruler

              " Display the incomplete commands in the bottom right-hand side of your screen.
              set showcmd

              " Display completion matches on your status line
              set wildmenu

              " Show a few lines of context around the cursor
              set scrolloff=5

              " Highlight search matches
              set hlsearch

              " Enable incremental searching
              set incsearch

              " Ignore case when searching
              set ignorecase

              " Override the 'ignorecase' option if the search pattern contains upper case characters.
              set smartcase

              " Turn on line numbering
              set number

              " Don't line wrap mid-word.
              set linebreak

              " Copy the indentation from the current line.
              set autoindent

              " Enable smart autoindenting.
              set smartindent

              " Use spaces instead of tabs
              set expandtab

              " Enable smart tabs
              set smarttab

              " Make a tab equal to 4 spaces
              set shiftwidth=4
              set tabstop=4

              " Easily create HTML unorded lists.
              map <F3> i<ul><CR><Space><Space><li></li><CR><Esc>I</ul><Esc>kcit
              map <F4> <Esc>o<li></li><Esc>cit
            '';
          };
        })
      ];
    };

    x = mkOption {
      type = types.listOf types.package;
      default = with pkgs; [
        alacritty
        mupdf
        peek gifski
        scrot
        xclip
      ];
    };

    image = mkOption {
      type = types.listOf types.package;
      default = with pkgs; [
        gimp
        plantuml graphviz
      ];
    };

    multimedia = mkOption {
      type = types.listOf types.package;
      default = with pkgs; [
        id3lib
        spotifywm
      ];
    };

    web = mkOption {
      type = types.listOf types.package;
      default = with pkgs; [
        firefox
        google-chrome
        thunderbird

        # Messengers
        signal-desktop
        tdesktop # Telegram
      ];
    };

    dev = mkOption {
      type = types.listOf types.package;
      default = with pkgs; [
        ansible
        docker-ls
        unstable.elmPackages.elm
        freerdp
        jetbrains.idea-ultimate
        lazydocker
        lnav
        unstable.mdcat
        nixops
        (sbt.override { stdenv = stdenv; fetchurl = fetchurl; jre = v.pkgs1903.jre8; })
        slack
        tmuxinator tmux
        visualvm
        vscode

        # REPLs
        ammonite # Scala
        python3
        spidermonkey # JS
      ];
    };

    office = mkOption {
      type = types.listOf types.package;
      default = with pkgs; [
        khal khard vdirsyncer
        mutt-with-sidebar offlineimap urlview w3m
        libreoffice
        sent # plaintext presentations
      ];
    };

    gaming = mkOption {
      type = types.listOf types.package;
      default = with pkgs; [
        playonlinux
        steam
        teamspeak_client
      ];
    };

    extra = mkOption {
      type = types.listOf types.package;
      default = [];
    };

    blacklist = mkOption {
      type = types.listOf types.package;
      default = [];
    };

  };

  config = {
    environment.systemPackages =
      let
        ff = p: ! builtins.elem p config.software.blacklist;
        all = config.software.common ++
              config.software.x ++
              config.software.image ++
              config.software.multimedia ++
              config.software.web ++
              config.software.dev ++
              config.software.office ++
              config.software.gaming ++
              config.software.extra;
      in
        builtins.filter ff all;
  };
}
