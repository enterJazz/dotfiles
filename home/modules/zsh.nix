{ pkgs , ... }:
{
  programs.zsh =
  {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    oh-my-zsh =
    {
      enable = true;
      plugins =
      [
        "git"
        "z"
      ];
      theme = "robbyrussell";
    };
    initExtra =
    ''
      DISABLE_UNTRACKED_FILES_DIRTY="true"
    '';
  };
}
