{ pkgs, ... }:
{
  imports =
  [
    ../modules/fzf.nix
    ../modules/zsh.nix
    ../modules/neovim.nix
    ../modules/direnv.nix
  ];
  home =
  {
    packages = with pkgs;
    [
      drawio
      tmux
      borgbackup
    ];
  };
}
