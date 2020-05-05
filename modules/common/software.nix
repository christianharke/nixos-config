{ config, pkgs, ... }:

with pkgs.lib;

let

  v = import ../../nixversions.nix {};

in

{

  options.software = {

    common = mkOption {
      type = types.listOf types.package;
      default = with pkgs; [
        # Terminal fun
        asciiquarium
        bb
        cowsay
        cmatrix
        figlet
        fortune
        lolcat
        toilet

        v.pkgsUnstable._1password
        bat
        bind
        broot
        convmv
        eva
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
        samba
        stow
        unzip
        (vim_configurable.customize {
          name = "vim";
          vimrcConfig = {
            packages.myplugins = with pkgs.vimPlugins; {
              # load plugin on startup
              start = [
                lightline-vim
                ranger-vim
                vim-css-color
                vim-gitbranch
                vim-gitgutter
                vimagit
                vimwiki
              ];
              # load plugin when necessary
              opt = [
                elm-vim
                vim-nix
              ];
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

              "
              " KEYMAPS
              "

              " Open terminal inside vim
              map <Leader>tt :terminal<CR>
              map <Leader>tv :vertical terminal<CR>

              " Splits and tabbed files
              set splitbelow splitright

              " Remap splits navigation to just CTRL + hjkl
              nnoremap <C-h> <C-w>h
              nnoremap <C-j> <C-w>j
              nnoremap <C-k> <C-w>k
              nnoremap <C-l> <C-w>l

              " Make adjusing split sizes a bit more friendly
              noremap <silent> <C-Left> :vertical resize +3<CR>
              noremap <silent> <C-Right> :vertical resize -3<CR>
              noremap <silent> <C-Up> :resize +3<CR>
              noremap <silent> <C-Down> :resize -3<CR>

              " Change 2 split windows from vert to horiz or horiz to vert
              map <Leader>th <C-w>t<C-w>H
              map <Leader>tk <C-w>t<C-w>K

              " Removes pipes | that act as seperators on splits
              set fillchars+=vert:\ 

              " Easily create HTML unorded lists.
              map <F3> i<ul><CR><Space><Space><li></li><CR><Esc>I</ul><Esc>kcit
              map <F4> <Esc>o<li></li><Esc>cit


              "
              " PLUGINS
              "

              " ranger
              map <leader>rr :RangerEdit<cr>
              map <leader>rv :RangerVSplit<cr>
              map <leader>rs :RangerSplit<cr>
              map <leader>rt :RangerTab<cr>
              map <leader>ri :RangerInsert<cr>
              map <leader>ra :RangerAppend<cr>
              map <leader>rc :set operatorfunc=RangerChangeOperator<cr>g@
              map <leader>rd :RangerCD<cr>
              map <leader>rld :RangerLCD<cr>

              " vimwiki
              set nocompatible
              filetype plugin on
              syntax on
              let nextcloud_notes = {}
              let nextcloud_notes.path = '~/Nextcloud/Notes/'
              let nextcloud_notes.syntax = 'markdown'
              let nextcloud_notes.ext = 'txt'
              let nextcloud_notes.list_margin = 0
              let g:vimwiki_list = [nextcloud_notes]
              let g:vimwiki_dir_link = 'index'

              " lightline
              set laststatus=2
              "set noshowmode " disabled since ranger-vim seems to break lightline sometimes
              set shortmess+=F
              let g:lightline = {
                \ 'active': {
                \   'left': [ [ 'mode', 'paste' ],
                \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
                \ },
                \ 'component_function': {
                \   'gitbranch': 'gitbranch#name'
                \ },
                \ }
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
        sxiv
      ];
    };

    multimedia = mkOption {
      type = types.listOf types.package;
      default = with pkgs; [
        id3lib
        mpv
        spotifywm
      ];
    };

    web = mkOption {
      type = types.listOf types.package;
      default = with pkgs; [
        firefox
        google-chrome
        qutebrowser
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
        ascii
        docker-ls
        elmPackages.elm
        freerdp
        jetbrains.idea-ultimate
        lazydocker
        lnav
        nixops
        sbt
        slack
        teams
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
        libreoffice
        sent # plaintext presentations
      ];
    };

    gaming = mkOption {
      type = types.listOf types.package;
      default = with pkgs; [
        discord
        v.pkgsMaster.lutris
        v.pkgsMaster.steam
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
