{ pkgs, stdenv, lib, ... }:
pkgs.buildGoModule
{
  name = "slackdump";
  src = pkgs.fetchFromGitHub
  {
    owner = "enterJazz";
    repo = "slackdump";
    rev = "patch-1";
    hash = "sha256-rlT9en6iTLF7Ohy+L/qqovWlSwOueUxO0u+eTzf+uCg=";
    # hash = "sha256-H2ZV7tPaXQRNCDqJt4yAyHAAT4KDL+NSz404pkyiwLI=";
  };

  vendorHash = "sha256-0O8LSGva9uga4D5L8wMAwKIMt/0UWxdlpndIAynEhoc=";

  buildInputs = with pkgs; [ go ];

  postInstall =
  ''
    install -Dm755 ./contrib/incremental_backup/dump.sh $out/bin/.
  '';
}

