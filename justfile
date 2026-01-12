# TODO: replace w/ NixOS
proot := justfile_directory()


default:
    just --choose

config:
    # may need to install bootloader
    sudo nixos-rebuild --upgrade --flake .#$(hostname) switch --impure

pc:
    nix run .#switch-$(whoami)-hm-pc

amalia:
    nix run .#switch-amalia --extra-experimental-features nix-command --extra-experimental-features flakes --show-trace


server:
    nix run .#switch-$(whoami)-hm-server

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
