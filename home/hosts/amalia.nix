{ pkgs, ... }:
{
  imports =
  [
    ../modules/fzf.nix
    ../modules/zsh.nix
    ../modules/neovim.nix
  ];
  home = {};
}
