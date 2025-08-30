{
  pkgs
  , config
  , ...
}:
{
  fonts.packages = with pkgs;
  [
    # nerdfonts # -> need to get the actual font I need explicitly...
    nerd-fonts.fira-code
    dejavu_fonts
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    liberation_ttf
    libertine
    font-awesome
  ];
  fonts.enableDefaultPackages = true;

}
