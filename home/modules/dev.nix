{ pkgs, ... }:
{
  home.packages = with pkgs;
  [
    cscope
    ctags
  ];
}
