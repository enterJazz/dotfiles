{ pkgs, lib, ... }:
{
  # nixpkgs' derivation, but pointed at the newest upstream release.
  # ./claude-code/manifest.json is refreshed with `just claude-update`.
  home.packages =
  [
    (pkgs.claude-code.override
    {
      manifest = lib.importJSON ./claude-code/manifest.json;
    })
  ];
}
