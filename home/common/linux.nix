{ pkgs, ... }:
{
  imports =
  [
    ../modules/fzf.nix
    ../modules/git.nix
    ../modules/neovim.nix
    # ../modules/ssh.nix
    ../modules/tmux.nix
    ../modules/zsh.nix
  ];
  home =
  {
    packages = with pkgs;
    [
      age
      findutils
      lazygit
      man-pages
      nix-index
      oath-toolkit
      tree
      unzip
      wget
      # rust linux tools
      bat
      dua
      eza
      fd
      ripgrep
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
