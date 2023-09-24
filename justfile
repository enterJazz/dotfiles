proot := justfile_directory()


default:
    just --choose

init-nixos-config:
    mkdir -p /etc/nixos
    @! sudo ln -s /etc/nixos/configuration.nix ./configuration.nix
    sudo nixos-rebuild --flake .#klamm switch

init-hm:
    nix run .#switch-robert-hm
