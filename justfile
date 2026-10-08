# TODO: replace w/ NixOS
proot := justfile_directory()


default:
    just --choose

config:
    # may need to install bootloader
    sudo nixos-rebuild --upgrade --flake .#frieda switch --impure

pc:
    nix run --impure .#switch-$(whoami)-hm-pc

amalia:
    nix run .#switch-amalia --extra-experimental-features nix-command --extra-experimental-features flakes --show-trace

frieda:
    nix run .#switch-frieda --extra-experimental-features nix-command --extra-experimental-features flakes --show-trace

server:
    nix run --impure .#switch-$(whoami)-hm-server

# pin claude-code to the newest upstream release, then re-switch home-manager
claude-update version="":
    #!/usr/bin/env bash
    set -euo pipefail
    base="https://downloads.claude.ai/claude-code-releases"
    version="{{version}}"
    [ -n "$version" ] || version=$(curl -fsSL "$base/latest")
    curl -fsSL "$base/$version/manifest.json" -o {{proot}}/home/modules/claude-code/manifest.json
    echo "claude-code -> $version"
    just pc

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
