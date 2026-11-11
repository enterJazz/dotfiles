{ pkgs, lib, ... }:
{

  imports =
  [
    ../common/linux.nix
    ../modules/claude-code.nix
  ];

  home = {
    packages = with pkgs;
    [
      cpuid
      dig
      rename
      # bitwarden
      pass
      hyfetch # provides neowofetch, the maintained neofetch fork
      htop
      docker-compose
      rustup
    ];
  };

  programs =
  {
    # zsh.oh-my-zsh.theme = lib.mkForce "avit";
    ssh =
    {
      enable = true;
      # the old home-manager defaults equal OpenSSH's own defaults
      enableDefaultConfig = false;
      settings =
      {
        # "*" is always written last
        "*".IdentityFile = "~/.ssh/keys/%r@%h";
      };
    };
    password-store =
    {
      enable = true;
    };
    gpg =
    {
      enable = true;
    };
  };
}
