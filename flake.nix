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
    homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration
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
        <sops-nix/modules/home-manager/sops.nix>
        ./home.nix
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
    
    # system configuration
    nixosConfigurations =
    {
      klamm = nixpkgs.lib.nixosSystem
      {
        inherit system;
	modules =
	[
	  ./nixos/configuration.nix
	  ./nixos/greetd.nix
	];
      };
    };

    apps.${system}."switch-${username}-hm" =
    {
      type = "app";
      program = "${self.homeConfigurations.${username}.activationPackage}/activate";
    };   
    devShells.${system}.default = pkgs.mkShell
    {
      name = "dotfiles-devshell";
      buildInputs = with pkgs;
      [
        just
        fzf
        age
      ];
    };
  };
}
