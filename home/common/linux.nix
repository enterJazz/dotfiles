{ pkgs, ... }:
{
  imports =
  [
    ../modules/fzf.nix
    ../modules/zsh.nix
    ../modules/ssh.nix
    ../modules/neovim.nix
  ];
  home =
  {
    packages = with pkgs;
    [
      lazygit
      wget
      unzip
      tree
      man-pages
      nix-index
      age
      tmux
      git
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
    direnv =
    {
      enable = true;
      # enableZshIntegration = true;
      nix-direnv.enable = true;
    };
  };
}
