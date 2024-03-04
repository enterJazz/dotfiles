{ pkgs, lib, ... }:
{
  programs.ssh =
  {
    enable = true;
    matchBlocks =
    {
      jumpHost = lib.hm.dag.entryBefore [ "dosServer" ]
      {
        user = "tunnel";
        hostname = "login.dos.cit.tum.de";
        identityFile = "~/.ssh/keys/dos.cit.tum.de";
      };
      dosServer = lib.hm.dag.entryBefore [ "any" ]
      {
        user = "robert";
        host = "*.dos.cit.tum.de";
        proxyJump = "jumpHost";
        identityFile = "~/.ssh/keys/dos.cit.tum.de";
      };
      any =
      {
        host = "*";
        identityFile = "~/.ssh/keys/%r@%h";
      };
    };
  };
}
