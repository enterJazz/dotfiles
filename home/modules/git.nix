{ ... }:
{
  programs.git =
  {
    enable = true;
    delta.enable = true;
    extraConfig =
    {
      merge.conflictStyle = "zdiff3";
      push.autoSetupRemote = "true";
    };
  };
}
