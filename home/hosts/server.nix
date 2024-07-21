{ pkgs, lib, ... }:
{

  imports =
  [
    ../common/linux.nix
  ];

  home = {
    packages = with pkgs;
    [
      cpuid
      dig
      rename
      # bitwarden
      pass
      ripgrep
      neofetch
    ];
  };

  programs =
  {
    # zsh.oh-my-zsh.theme = lib.mkForce "avit";
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
