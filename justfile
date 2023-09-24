proot := justfile_directory()


default:
    just --choose

init-nixos-config:
    @ mkdir -p /etc/nixos
    @! sudo ln ./nixos/* /etc/nixos/*
    sudo nixos-rebuild --flake .#klamm switch

init-hm:
    @ mkdir -p ~/.config/home-manager
    @! ln home.nix ~/.config/home-manager/home.nix
    nix run .#switch-robert-hm

init-ssh-conf:
    @ mkdir -p ~/.ssh/keys
    @ ln config ~/.ssh/config
