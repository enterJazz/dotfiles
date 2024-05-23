{ pkgs, ... }:
{
  programs.vscode =
  {
    enable = true;
    extensions = with pkgs.vscode-extensions;
    [
      vscodevim.vim
      ms-vscode-remote.remote-ssh
      ms-vscode-remote.remote-containers
    ];
  };
}
