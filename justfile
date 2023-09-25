proot := justfile_directory()


default:
    just --choose

init-nixos-config:
    sudo nixos-rebuild --flake .#klamm switch

init-hm:
    nix run .#switch-robert-hm

init-links:
    @ mkdir -p ~/.ssh/keys \
      ~/.config/home-manager
    @ sudo mkdir -p /etc/nixos \
      /etc/nixos/openvpn
    @ ln config ~/.ssh/config
    @ ln home.nix ~/.config/home-manager/home.nix
    @ sudo ln ./nixos/* /etc/nixos/*
    @ sudo ln ./network/openvpn/* /etc/nixos/openvpn/.

