{ ... }:
{
  programs.tmux =
  {
    enable = true;
    clock24 = true;
    customPaneNavigationAndResize = true;
    historyLimit = 10000;
    keyMode = "vi";
    mouse = true;
  };
}
