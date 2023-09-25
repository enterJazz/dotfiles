{ pkgs, ... }:
{
  home = {
    packages = with pkgs;
    [
      alacritty
      tree
      man-pages
      nix-index
      age
      tmux
      git
      rename
      firefox-wayland
      bitwarden
      thunderbird
      mako
      wl-clipboard
      shotman
      telegram-desktop
      signal-desktop
      slack
      obsidian
      zotero
    ];
    sessionVariables =
    {
      MOZ_ENABLE_WAYLAND = 1;
      XDG_CURRENT_DESKTOP = "sway";
    };
  };

  programs =
  {
    firefox =
    {
      enable = true;
      profiles.robert =
      {
        name = "robert";
        id = 0;
        search =
        {
          default = "DuckDuckGo";
          force = true;
          engines =
          {
            "Nix Packages" = {
              urls =
              [{
                  template = "https://search.nixos.org/packages";
                  params =
                  [
                      { name = "type"; value = "packages"; }
                      { name = "query"; value = "{searchTerms}"; }
                  ];
              }];
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = [ "@np" ];
            };
            "NixOS Wiki" =
            {
              urls = [{ template = "https://nixos.wiki/index.php?search={searchTerms}"; }];
              iconUpdateURL = "https://nixos.wiki/favicon.png";
              updateInterval = 24 * 60 * 60 * 1000;
              definedAliases = [ "@nw" ];
            };
            "Wikipedia (en)".metaData.alias = "@wiki";
            "Google".metaData.hidden = true;
            "Amazon.com".metaData.hidden = true;
            "Bing".metaData.hidden = true;
            "eBay".metaData.hidden = true;
          };
        };
        extensions = with pkgs.nur.repos.rycee.firefox-addons;
        [
          ublock-origin
          privacy-badger
          bitwarden
          clearurls
          decentraleyes
        ];
        isDefault = true;
      };
    };
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
