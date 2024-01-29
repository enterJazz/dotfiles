{
  pkgs
  , lib
  , ...
}:
let
  # TODO: include as flake input
  vim-just = pkgs.vimUtils.buildVimPlugin
  {
    pname = "vim-just";
    version = "0.0.0";
    src = pkgs.fetchFromGitHub
    {
      owner = "NoahTheDuke";
      repo = "vim-just";
      rev = "c2c785b61eb5d5eddd8fe64e6856c9bf8988a3c4";
      hash = "sha256-QAIPxd0jptR9j6kY1utZmXY4353/FN6UP0wfv/Z/H8k=";
    };
  };

  vim-yoink = pkgs.vimUtils.buildVimPlugin
  {
    pname = "vim-yoink";
    version = "0.0.0";
    src = pkgs.fetchFromGitHub
    {
      owner = "svermeulen";
      repo = "vim-yoink";
      rev = "89ed6934679fdbc3c20f552b50b1f869f624cd22";
      hash = "sha256-ekGKOYzmdaMqAun/3fRGlhA7bLKuhzsXsEcFNukgFWU=";
    };
  };
  vim-cutlass = pkgs.vimUtils.buildVimPlugin
  {
    pname = "vim-cutlass";
    version = "0.0.0";
    src = pkgs.fetchFromGitHub
    {
      owner = "svermeulen";
      repo = "vim-cutlass";
      rev = "7afd649415541634c8ce317fafbc31cd19d57589";
      hash = "sha256-j5W9q905ApDf3fvCIS4UwyHYnEZu5Ictn+6JkV/xjig=";
    };
  };
in
{
  # required for coc
  home.packages = with pkgs;
  [
    ## nix
    # A sensible formatter for nix code.
    nixpkgs-fmt
    
    # An LSP for nix.
    rnix-lsp

    ## rust: see https://github.com/iamthememory/dotfiles/blob/main/home/neovim/filetypes/rust.nix
    # for when I need it

    ## C
    clang_16
    clang-tools_16
  ];

  programs.neovim =
  {
    enable = true;
    viAlias = true;
    vimAlias = true;
    coc =
    {
      enable = true;
      settings =
      {
        ## C
        "clangd.arguments" =  [ "--clang-tidy" ];
        "clangd.fallbackFlags" =  [ "-stdc++17" ];

        languageserver.nix =
        {
          # The command to run.
          command = "rnix-lsp";

          # Run on nix files.
          filetypes =
          [
            "nix"
          ];
        };
      };
    };
    defaultEditor = true;
    plugins = with pkgs.vimPlugins;
    [
      copilot-vim
      vim-toml
      vim-surround
      vim-repeat
      ale
      {
        plugin = vim-easy-align;
        config =
        ''
          " Start interactive EasyAlign in visual mode (e.g. vipga)
          xmap ga <Plug>(EasyAlign)

          " Start interactive EasyAlign for a motion/text object (e.g. gaip)
          nmap ga <Plug>(EasyAlign)
        '';
      }
      vim-gitgutter
      nvim-lspconfig
      coc-pyright
      vim-just
    ] ++
    [
      {
        plugin = vim-yoink;
        config =
        ''
          " vim-yoink config
          " swap most recent paste around in yank history
          nmap <c-n> <plug>(YoinkPostPasteSwapBack)
          nmap <c-p> <plug>(YoinkPostPasteSwapForward)

          " use vimyank for pasting
          nmap p <plug>(YoinkPaste_p)
          nmap P <plug>(YoinkPaste_P)

          " permanently cycle through history
          nmap [y <plug>(YoinkRotateBack)
          nmap ]y <plug>(YoinkRotateForward)

          " toggle if current paste is formatted
          nmap <c-=> <plug>(YoinkPostPasteToggleFormat)
        '';
      }
      {
        plugin = vim-cutlass;
        config =
        ''
          " vimcutlass: add cut operations to Yank history
          let g:yoinkIncludeDeleteOperations = 1

          " vimcutlass: map 'r' as cut
          nnoremap r d
          xnoremap r d

          nnoremap rr dd
          nnoremap R D
        '';
      }
    ];
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

      " remove highlight
      nnoremap <silent> <esc> :noh<cr><esc>

      " show current line number
      set number
      " show relative line numbers
      set relativenumber

      " https://stackoverflow.com/a/6638381
      ca tn tabnew
      ca th tabp
      ca tl tabn
    '';
  };
}


