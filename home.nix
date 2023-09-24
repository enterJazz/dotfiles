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
