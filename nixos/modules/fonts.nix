{
  pkgs
  , config
  , ...
}:
{
  fonts.packages = with pkgs;
  [
    nerdfonts
    dejavu_fonts
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    libertine
    font-awesome
  ];
  fonts.enableDefaultPackages = true;

}
