{ pkgs, stdenv, lib, ... }:
stdenv.mkDerivation rec
{
  name = "slackdump";
  version = "2.5.3";
  src = pkgs.fetchurl
  {
    url = "https://github.com/rusq/slackdump/releases/download/v${version}/slackdump_Linux_x86_64.tar.gz";
    hash = "sha256-93NwpXK74lRC/8RVKPJ8TPWgDRbdcDKkSMY0WUMftEQ=";
  };

  sourceRoot = ".";

  installPhase =
  ''
    install -m755 -D slackdump $out/bin/slackdump
  '';
}

