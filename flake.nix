{
  description = "My NixOS Dotfiles";

  inputs =
  {
    nixpkgs.url = "github:NixOs/nixpkgs/nixos-25.05";
    # unstable-nixpkgs.url = "github:NixOs/nixpkgs/nixpkgs-unstable";

    home-manager =
    {
      url = "github:nix-community/home-manager/release-25.05";
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

    # NOTE: appears to currently break building of nixos-options? (since 25.05)
    # lix-module =
    # {
    #   url = "https://git.lix.systems/lix-project/nixos-module/archive/2.90.0.tar.gz";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
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
    # , lix-module
    , ... }:
  # https://flake.parts/getting-started
  flake-parts.lib.mkFlake { inherit inputs; }
  {
    # ex: https://github.com/DioxusLabs/dioxus/blob/0a4603d30e0e2942438c6cbf1bc66e88cb635a8e/flake.nix#L11
#      perSystem =
#      {
#        pkgs
#        , system
#        , ...
#      }:
#      let
#        username = "robert";
#      in
#      {
#  #       homeConfigurations =
#  #       {
#  #         # Q: HM per machine? or per OS?
#  #         # common config
#  #         # specialize per host
#  #       };
#        packages = {
#        };
#      };
    systems =
    [
      "x86_64-linux"
    ];
    flake =
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      username = "robert";
      hmpkgs = import nixpkgs
      {
        inherit system;
        config.allowUnfree = true;
        overlays = [ nur.overlays.default ];
        config.permittedInsecurePackages = [ "electron-25.9.0" "nix-2.15.3" ];
      };
    in
    {
# home configuration
      homeConfigurations =
      {
        "${username}-pc" = home-manager.lib.homeManagerConfiguration
        {
# workaround: https://github.com/nix-community/home-manager/issues/2942#issuecomment-1378627909
          pkgs = hmpkgs;
          modules =
          [
          ./home/pc.nix
            {
              home =
              {
                username = "${username}";
                homeDirectory = "/home/${username}";
                stateVersion = "25.05";
              };
            }
          ];
        };
        "${username}-server" = home-manager.lib.homeManagerConfiguration
        {
# workaround: https://github.com/nix-community/home-manager/issues/2942#issuecomment-1378627909
          pkgs = hmpkgs; 
          modules =
          [
# <sops-nix/modules/home-manager/sops.nix>
          ./home/hosts/server.nix
            {
              home =
              {
                username = "${username}";
                homeDirectory = "/home/${username}";
                stateVersion = "25.05";
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
              sops-nix.nixosModules.sops
              lanzaboote.nixosModules.lanzaboote
              # lix-module.nixosModules.default
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
