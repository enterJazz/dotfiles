# TODO: replace w/ NixOS
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
      /etc/nixos/openvpn/vpn-il11-2.4-linux
    @ ln config ~/.ssh/config
    @ ln home.nix ~/.config/home-manager/home.nix
    @ sudo ln ./nixos/* /etc/nixos/*
    @ sudo ln ./network/openvpn/vpn-il11-2.4-linux/vpn-il11-2.4-linux.ovpn /etc/nixos/openvpn/.

init-keys:
    mkdir -p ~/.config/sops/age
    age-keygen -o ~/.config/sops/age/keys.txt
