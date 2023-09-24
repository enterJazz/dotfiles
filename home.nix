{ pkgs, ... }:
{
  home.packages = with pkgs;
  [
    alacritty
    tree
    man-pages
    nix-index
    age
    tmux
    git
    rename
    firefox
    bitwarden
    thunderbird
    mako
    wl-clipboard
    shotman
    telegram-desktop
    signal-desktop
    slack
    obsidian
  ];

  programs =
  {
    neovim =
    {
      enable = true;
      viAlias = true;
      vimAlias = true;
      coc =
      {
        enable = true;
	settings =
	''
	'';
      };
      defaultEditor = true;
      extraConfig =
      ''
        set showmatch
        set errorbells

        set hlsearch
        set smartcase
        set incsearch

        set autoindent
	set expandtab
	set shiftwidth=2
	set smartindent
	set smarttab
	set softtabstop=4

        set wrap linebreak nolist

	" autocmd FileType yaml ts=2 sts=2 sw=2 expandtab
	" autocmd FileType nix ts=2 sts=2 sw=2 expandtab

        set directory^=$HOME/.config/nvim/vimswap//
        set fsync

        set ruler	

        set undolevels=1000	
        set backspace=indent,eol,start	

        set undofile
        set undodir=/home/robert/.config/nvim/.vimundo/

        call plug#begin('~/.local/share/nvim/plugged')

        Plug 'cespare/vim-toml'
        Plug 'https://tpope.io/vim/surround.git'
        Plug 'svermeulen/vim-yoink'
        Plug 'tpope/vim-repeat'
        Plug 'svermeulen/vim-cutlass'
        Plug 'aliou/bats.vim'
        Plug 'vim-scripts/LargeFile'
        "Plug 'vim-syntastic/syntastic'
        Plug 'rust-lang/rust.vim'
        Plug 'junegunn/vim-easy-align'
        Plug 'airblade/vim-gitgutter'
        Plug 'NoahTheDuke/vim-just'
        "Plug 'neovim/nvim-lspconfig'
        " :GrammarousCheck --help
        " :[range]GrammarousCheck [--lang={lang}] [--(no-)preview] [--(no-)comments-only]


        call plug#end()


        "vim-easy-align config
        " Start interactive EasyAlign in visual mode (e.g. vipga)
        xmap ga <Plug>(EasyAlign)

        " Start interactive EasyAlign for a motion/text object (e.g. gaip)
        nmap ga <Plug>(EasyAlign)


        "bats.vim config
        let g:bats_vim_consider_dollar_as_part_of_word = 0


        "vim-yoink config
        "swap most recent paste around in yank history
        nmap <c-n> <plug>(YoinkPostPasteSwapBack)
        nmap <c-p> <plug>(YoinkPostPasteSwapForward)

        "use vimyank for pasting
        nmap p <plug>(YoinkPaste_p)
        nmap P <plug>(YoinkPaste_P)

        "permanently cycle through history
        nmap [y <plug>(YoinkRotateBack)
        nmap ]y <plug>(YoinkRotateForward)

        "toggle if current paste is formatted
        nmap <c-=> <plug>(YoinkPostPasteToggleFormat)

        "vimcutlass: add cut operations to Yank history
        let g:yoinkIncludeDeleteOperations = 1

        "remove highlight
        nnoremap <silent> <esc> :noh<cr><esc>

        "syntastic: recommended defaults
        "set statusline+=%#warningmsg#
        "set statusline+=%{SyntasticStatuslineFlag()}
        "set statusline+=%*
        "
        "let g:syntastic_always_populate_loc_list = 1
        "let g:syntastic_auto_loc_list = 1
        "let g:syntastic_check_on_open = 1
        "let g:syntastic_check_on_wq = 0

        "vim-gitgutter config
        set updatetime=100
        "GitGutterLineNrHighlightsEnable

        "lua-specific config
        " - lsp
        "NOTE: requires neovim v0.5
        "lua require('init')
      '';
    };
    direnv =
    {
      enable = true;
      # enableZshIntegration = true;
      nix-direnv.enable = true;
    };
    zsh =
    {
      enable = true;
      oh-my-zsh =
      {
        enable = true;
        plugins =
        [
          "git"
          "z"
          # "zsh-autosuggestions"
        ];
        theme = "robbyrussell";
      };
    };
  };
  # from nixos.wiki/wiki/Sway
  wayland.windowManager.sway =
  {
    enable = true;
    config = rec
    {
      modifier = "Mod4";
      output =
      {
        "Virtual-1" =
	{
	  mode = "1920x1080@60Hz";
	};
      };
    };
    extraConfig =
    ''
      bindsym Print exec shotman -c output
      bindsym Print+Shift exec shotman -c region
      bindsym Print+Shift+Control exec shotman -c window
    '';
  };

}
