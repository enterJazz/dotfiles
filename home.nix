{
  programs =
  {
    neovim =
    {
      enable = true;
      viAlias = true;
      vimAlias = true;
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
  };

}
