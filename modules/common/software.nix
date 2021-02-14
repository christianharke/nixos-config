{ config, pkgs, ... }:

with pkgs.lib;

let

  v = import ../../nixversions.nix {};

in

{
  imports = import ../../pkgs/modules.nix;

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
        _1password-gui
        bat
        bind
        broot
        convmv
        direnv
        eva
        exa
        fd # ultra-fast find
        file
        fzf # fuzzy find
        git
        glow
        gnupg
        gron
        htop
        jq
        killall
        lazygit
        neofetch
        parted exfat
        ranger
        samba
        starship
        stow
        trash-cli
        unzip
        (vim_configurable.customize {
          name = "vim";
          vimrcConfig = {
            packages.myplugins = with pkgs.vimPlugins; {
              # load plugin on startup
              start = [
                direnv
                fzf
                lightline-vim
                nerdcommenter
                ranger-vim
                vim-css-color
                vim-devicons
                vim-fugitive
                vim-startify
                vim-surround
                vimwiki mattn-calendar-vim
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

              " Enable relative line numbers
              set relativenumber

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

              " Remap leader key
              let mapleader = ","

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

              " Insert shebang at the beginning
              map <F2> <Esc>ggO#!/usr/bin/env 


              "
              " MARKDOWN
              "

              " Treat all .md files as markdown
              autocmd BufNewFile,BufRead *.md set filetype=markdown

              " Set spell check to British English
              autocmd FileType markdown setlocal spell spelllang=en_gb

              " Set text width
              autocmd FileType markdown setlocal textwidth=100

              " Treat fenced languages as such
              let g:markdown_fenced_languages = ['bash=sh', 'sh', 'html', 'groovy', 'java', 'js=javascript', 'python', 'rust', 'vim']


              "
              " TEMPLATES
              "
              if has("autocmd")
                augroup templates
                  autocmd BufNewFile *.sh 0r ~/.config/vim/templates/skeleton.sh
                augroup END
              endif


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

              function! VimwikiFindIncompleteTasks()
                lvimgrep /- \[ \]/ %:p
                lopen
              endfunction

              function! VimwikiFindAllIncompleteTasks()
                VimwikiSearch /- \[ \]/
                lopen
              endfunction

              :autocmd FileType vimwiki map wa :call VimwikiFindAllIncompleteTasks()<CR>
              :autocmd FileType vimwiki map wx :call VimwikiFindIncompleteTasks()<CR>

              function! ToggleCalendar()
                execute ":Calendar"
                if exists("g:calendar_open")
                  if g:calendar_open == 1
                    execute "q"
                    unlet g:calendar_open
                  else
                    g:calendar_open = 1
                  end
                else
                  let g:calendar_open = 1
                end
              endfunction
              :autocmd FileType vimwiki map <leader>c :call ToggleCalendar()<CR>

              " lightline
              set laststatus=2
              "set noshowmode " disabled since ranger-vim seems to break lightline sometimes
              set shortmess+=F
              let g:lightline = {
              \   'active': {
              \     'left': [ [ 'mode', 'paste' ],
              \               [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
              \   },
              \   'tab': {
              \     'active': [ 'filetype', 'filename', 'modified' ],
              \     'inactive': [ 'filetype', 'filename', 'modified' ]
              \   },
              \   'component_function': {
              \     'gitbranch': 'FugitiveHead',
              \     'filetype': 'LightlineWebDevIconsFiletype',
              \     'fileformat': 'LightlineWebDevIconsFileformat'
              \   },
              \   'tab_component_function': {
              \     'filetype': 'LightlineTabWebDevIconsFiletype'
              \   }
              \ }

              function! LightlineWebDevIconsFiletype()
                return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : '''
              endfunction

              function! LightlineWebDevIconsFileformat()
                return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : '''
              endfunction

              function! LightlineTabWebDevIconsFiletype(n)
                let l:bufnr = tabpagebuflist(a:n)[tabpagewinnr(a:n) - 1]
                return WebDevIconsGetFileTypeSymbol(bufname(l:bufnr))
              endfunction
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
        ascii
        v.pkgsUnstable.jetbrains.idea-ultimate
        lnav
        nixops
        tmuxinator tmux
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
              config.software.extra;
      in
        builtins.filter ff all;
  };
}
