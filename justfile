proot := justfile_directory()


default:
    just --choose

init-nixos-config:
    sudo nixos-rebuild --flake .#klamm switch

init-hm:
    nix run .#switch-robert-hm

init-links:
    @ mkdir -p ~/.ssh/keys ~/.config/home-manager /etc/nixos
    @ ln config ~/.ssh/config
    @ ln home.nix ~/.config/home-manager/home.nix
    @ sudo ln ./nixos/* /etc/nixos/*
