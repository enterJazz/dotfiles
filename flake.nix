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
    # from https://codeberg.org/kiara/cfg/commit/a14a0684c3ba11fa3726b3ac316ca74f2a5249d5#diff-2c05bdb636b4175a69fb147fa6f9d4e037cc092c
    nixpkgs-unfree.url = "github:numtide/nixpkgs-unfree";
  };

  outputs =
  {
    self
    , nixpkgs
    , nixpkgs-unfree
    , home-manager
    , nur
    , sops-nix
    , ... }:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    unfree-pkgs = nixpkgs-unfree.legacyPackages.${system};
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
          config.permittedInsecurePackages = [ "electron-24.8.6" ];
        };
        extraSpecialArgs = { unfree = unfree-pkgs; };
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
