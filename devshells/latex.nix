{ pkgs ? import <nixpkgs> {} }:
let
  tex = (pkgs.texlive.combine
  {
    # texlive deps in https://github.com/NixOS/nixpkgs/blob/nixos-21.05/pkgs/tools/typesetting/tex/texlive/pkgs.nix
    inherit (pkgs.texlive)
    scheme-full
    ;
  });

in
pkgs.mkShell
{
  buildInputs =
  with pkgs;
  [
    gnumake
    biber
  ]
  ++
  [
    tex
  ];
}
