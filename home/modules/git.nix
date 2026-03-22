{ ... }:
{
  programs = {
    delta = {
      enable = true;
      enableGitIntegration = true;
    };
    git = {
      enable = true;
      settings =
      {
         merge.conflictStyle = "zdiff3";
         push.autoSetupRemote = "true";
      };
    };
  };
}
