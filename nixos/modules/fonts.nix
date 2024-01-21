{
  pkgs
  , config
  , ...
}:
{
  fonts.packages = with pkgs;
  [
    (nerdfonts.override { fonts = [ "DroidSansMono"]; })
    dejavu_fonts
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    libertine
  ];

}
