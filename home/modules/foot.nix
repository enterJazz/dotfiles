{ pkgs, ... }:
{
  programs.foot =
  {
    enable = true;
    settings =
    {
      main = { dpi-aware = "yes"; };
      mouse = { hide-when-typing = "yes"; };
    };
  };
}
