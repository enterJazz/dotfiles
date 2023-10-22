{ pkgs , ... }:
{
  programs.zsh =
  {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
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
  };
}
