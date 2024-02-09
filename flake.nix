{
  description = "A very basic flake";

  inputs =
  {
    nixpkgs.url = "github:NixOs/nixpkgs/nixos-23.11";
    home-manager =
    {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/NUR";
    sops-nix.url = "github:Mic92/sops-nix";
    lanzaboote =
    {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-parts.inputs.nixpkgs-lib.follows = "nixpkgs";
  };

  outputs =
  inputs@{
    self
    , nixpkgs
    , home-manager
    , nur
    , sops-nix
    , lanzaboote
    , flake-parts
    , ... }:
  flake-parts.lib.mkFlake { inherit inputs; }
  {
    perSystem = { ... }:
    {
        packages = {
        };
    };
    systems =
    [
      "x86_64-linux"
      "aarch64-linux"
    ];
    flake =
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      username = "robert";
    in
    {
# home configuration
      homeConfigurations =
      {
        "${username}-pc" = home-manager.lib.homeManagerConfiguration
        {
# workaround: https://github.com/nix-community/home-manager/issues/2942#issuecomment-1378627909
          pkgs = import nixpkgs
          {
            inherit system;
            config.allowUnfree = true;
            overlays = [ nur.overlay ];
            config.permittedInsecurePackages = [ "electron-25.9.0" ];
          };
          modules =
            [
# <sops-nix/modules/home-manager/sops.nix>
            ./home/pc.nix
            {
              home =
              {
                username = "${username}";
                homeDirectory = "/home/${username}";
                stateVersion = "23.05";
              };
            }
            ];
        };
        "${username}-server" = home-manager.lib.homeManagerConfiguration
        {
# workaround: https://github.com/nix-community/home-manager/issues/2942#issuecomment-1378627909
          pkgs = import nixpkgs
          {
            inherit system;
            config.allowUnfree = true;
            overlays = [ nur.overlay ];
          };
          modules =
            [
# <sops-nix/modules/home-manager/sops.nix>
            ./home/server.nix
            {
              home =
              {
                username = "${username}";
                homeDirectory = "/home/${username}";
                stateVersion = "23.05";
              };
            }
            ];
        };
      };

# system configuration
      nixosConfigurations =
      {
        klamm = nixpkgs.lib.nixosSystem
        {
          inherit system;
          modules =
            [
            ./nixos/hosts/klamm.nix
              sops-nix.nixosModules.sops
            ];
        };

        barnabas = nixpkgs.lib.nixosSystem
        {
          inherit system;
          modules =
            [
            ./nixos/hosts/barnabas.nix
# TODO refactor
              sops-nix.nixosModules.sops
              lanzaboote.nixosModules.lanzaboote
            ];
        };
      };

      apps.${system} =
      {
        "switch-${username}-hm-pc" =
        {
          type = "app";
          program = "${self.homeConfigurations."${username}-pc".activationPackage}/activate";
        };
        "switch-${username}-hm-server" =
        {
          type = "app";
          program = "${self.homeConfigurations."${username}-server".activationPackage}/activate";
        };
      };
      devShells.${system}.default = pkgs.mkShell
      {
        name = "dotfiles-devshell";
        buildInputs = with pkgs;
        [
          just
          fzf
          age
          sops
        ];
      };
    };
  };
}
