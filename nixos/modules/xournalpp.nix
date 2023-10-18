{
  pkgs
  , config
  , ... }:
{
  environment =
  {
    # xournalpp fix https://github.com/NixOS/nixpkgs/issues/163107
    systemPackages = with pkgs;
    [
      gnome.adwaita-icon-theme
      shared-mime-info
    ];
    pathsToLink =
    [
      "/share/icons"
      "/share/mime"
    ];
  };
}
