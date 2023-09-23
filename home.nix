{ pkgs, username, ... }:
{
  home =
  {
    packages = with pkgs;
      [
        vim
        tree
        man-pages
        nix-index
        age
        tmux
        git
        rename
      ];
  
    username = ${username};
    homeDirectory = "/home/${username}";
  
    programs =
    {
      direnv =
      {
        enable = true;
        enableZshIntegration = true;
        nix-direnv.enable = true;
      };
      zsh.enable = true;
    };  
  };
}
