proot := justfile_directory()


init-nixos-config:
    mkdir -p /etc/nixos
    sudo cp ./configuration.nix /etc/nixos/configuration.nix
    sudo nixos-rebuild switch

init-hm:
    nix run .#switch-robert-hm
