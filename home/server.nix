{ pkgs, lib, ... }:
{

  imports =
  [
    ./modules/fzf.nix
    ./modules/zsh.nix
    ./modules/neovim.nix
    ./modules/ssh.nix
    ./modules/dev.nix
  ];

  home = {
    packages = with pkgs;
    [
      lazygit
      cpuid
      dig
      wget
      unzip
      tree
      man-pages
      nix-index
      age
      tmux
      git
      rename
      # bitwarden
      pass
    ];
  };

    nix =
    {
      package = pkgs.nix;
      settings.experimental-features =
      [
        "nix-command"
        "flakes"
        # "allow-import-from-derivation"
      ];
    };

  programs =
  {
    direnv =
    {
      enable = true;
      # enableZshIntegration = true;
      nix-direnv.enable = true;
    };
    zsh.oh-my-zsh.theme = lib.mkForce "avit";
    ssh =
    {
      enable = true;
      matchBlocks =
      {
        dosServer = lib.hm.dag.entryBefore [ "any" ]
        {
          host = "*.dos.cit.tum.de";
          identityFile = "~/.ssh/keys/dos.cit.tum.de";
        };
        any =
        {
          host = "*";
          identityFile = "~/.ssh/keys/%r@%h";
        };
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
