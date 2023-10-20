{
  description = "A very basic flake";

  inputs =
  {
    nixpkgs.url = "github:NixOs/nixpkgs/nixos-23.05";
    home-manager =
    {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/NUR";
    sops-nix.url = "github:Mic92/sops-nix";
  };

  outputs =
  {
    self
    , nixpkgs
    , home-manager
    , nur
    , sops-nix
    , ... }:
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
	];
      };

      barnabas = nixpkgs.lib.nixosSystem
      {
        inherit system;
	modules =
	[
	  ./nixos/hosts/barnabas.nix
          # TODO refactor
          # sops-nix.nixosModules.sops
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
}
