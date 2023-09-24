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
  };

  outputs = { self, nixpkgs, home-manager, ... }:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    username = "robert";
  in
  {
    homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration
    {
      inherit pkgs;
      modules =
      [
        ./home.nix
        {
          home =
          {
            packages = with pkgs;
            [
	      alacritty
              tree
              man-pages
              nix-index
              age
              tmux
              git
              rename
	      firefox
	      bitwarden
            ];
          
            username = "${username}";
            homeDirectory = "/home/${username}";
            stateVersion = "23.05";
          };
        }
      ];
    };

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
      ];
    };
  };
}
