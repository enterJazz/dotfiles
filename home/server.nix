{ pkgs, lib, ... }:
{
  home = {
    packages = with pkgs;
    [
      dig
      wget
      unzip
      tree
      man-pages
      nix-index
      age
      tmux
      git
      rename
      # bitwarden
      # syncthing
      pass
    ];
  };

    nix =
    {
      package = pkgs.nix;
      settings.experimental-features =
      [
        "nix-command"
        "flakes"
        # "allow-import-from-derivation"
      ];
    };

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
      plugins = with pkgs.vimPlugins;
      [
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
    direnv =
    {
      enable = true;
      # enableZshIntegration = true;
      nix-direnv.enable = true;
    };
    zsh =
    {
      enable = true;
      enableCompletion = true;
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
    ssh =
    {
      enable = true;
      matchBlocks =
      {
        dosServer = lib.hm.dag.entryBefore [ "any" ]
        {
          host = "*.dos.cit.tum.de";
          identityFile = "~/.ssh/keys/dos.cit.tum.de";
        };
        any =
        {
          host = "*";
          identityFile = "~/.ssh/keys/%r@%h";
        };
      };
    };
    password-store =
    {
      enable = true;
    };
    gpg =
    {
      enable = true;
    };
  };
}
