{ pkgs, lib, ... }:
{
  programs.ssh =
  {
    enable = true;
    matchBlocks =
    {
      any =
      {
        host = "*";
        identityFile = "~/.ssh/keys/%r@%h";
      };
    };
  };
}
