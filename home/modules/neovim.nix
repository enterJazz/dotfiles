{ pkgs, lib, ... }:
{
  programs.neovim =
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
    plugins = with pkgs.vimPlugins;
    [
      copilot-vim
      vim-toml
      vim-surround
      # {
      #   plugin = vim-yoink;
      #   config =
      #   ''
      #     " vim-yoink config
      #     " swap most recent paste around in yank history
      #     nmap <c-n> <plug>(YoinkPostPasteSwapBack)
      #     nmap <c-p> <plug>(YoinkPostPasteSwapForward)

      #     " use vimyank for pasting
      #     nmap p <plug>(YoinkPaste_p)
      #     nmap P <plug>(YoinkPaste_P)

      #     " permanently cycle through history
      #     nmap [y <plug>(YoinkRotateBack)
      #     nmap ]y <plug>(YoinkRotateForward)

      #     " toggle if current paste is formatted
      #     nmap <c-=> <plug>(YoinkPostPasteToggleFormat)
      #   '';
      # }
      vim-repeat
      # {
      #   plugin = vim-cutlass;
      #   config =
      #   ''
      #     " vimcutlass: add cut operations to Yank history
      #     let g:yoinkIncludeDeleteOperations = 1
      #   '';
      # }
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
      # vim-just
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
    '';
  };
}

