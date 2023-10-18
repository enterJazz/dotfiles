{ pkgs, lib, ... }:
{
  home = {
    packages = with pkgs;
    [
      libreoffice
      evince
      authy
      wget
      unzip
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
      zathura
      syncthing
      drawio
      protonmail-bridge
      pass # protonmail integration ; todo: integrate correctly
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
            "Google Scholar" =
            {
              urls = [{ template = "https://scholar.google.com/scholar?hl=en&q={searchTerms}"; }];
              icon = "https://upload.wikimedia.org/wikipedia/commons/c/c7/Google_Scholar_logo.svg";
              definedAliases = [ "@scholar" ];
            };
            "GitHub" =
            {
              urls = [{ template = "https://github.com/search?q={searchTerms}&type=repositories"; }];
              icon = "https://upload.wikimedia.org/wikipedia/commons/9/95/Font_Awesome_5_brands_github.svg";
              definedAliases = [ "@gh" ];
            };
            "Nix Packages" =
            {
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
        settings =
        {
          "browser.startup.homepage" = "https://nixos.org";
          "browser.search.region" = "DE";
          "browser.search.isUS" = false;
          "distribution.searchplugins.defaultLocale" = "de-DE";
          "general.useragent.locale" = "de-DE";
          "browser.bookmarks.showMobileBookmarks" = false;
          "browser.toolbars.bookmarks.showOtherBookmarks" = false;
          "browser.compactmode.show" = true;
          "browser.newtabpage.pinned" = [{
            title = "NixOS";
            url = "https://nixos.org";
          }];
          "extensions.pocket.enabled" = false;
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
    zathura =
    {
      enable = true;
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
    swaylock =
    {
      enable = true;
      settings =
      {
        color = "808080";
        font-size = 24;
        indicator-idle-visible = false;
        indicator-radius= 100;
        line-color = "ffffff";
        show-failed-attempts = true;
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
  
  services =
  {
    syncthing =
    {
      enable = true;
    };
    mako =
    {
      enable = true;
      extraConfig =
      ''
        [urgency=low]
        border-color=#cccccc

        [urgency=normal]
        border-color=#d08770

        [urgency=high]
        border-color=#bf616a
        default-timeout=0

        [category=mpd]
        default-timeout=2000
        group-by=category
      '';
    };
    # need this for pass
    gpg-agent =
    {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
