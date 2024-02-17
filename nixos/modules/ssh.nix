{
  pkgs
  , config
  , ...
}:
{
  programs.ssh =
  {
    extraConfig =
    ''
    Host gitlab.lrz.de
      User git
      IdentityFile ${config.sops.secrets.gitlab-lrz.path}

    Host github.com
      User git
      IdentityFile ${config.sops.secrets.github.path}
    '';
    knownHosts =
    {
      "github.com" =
      {
        hostNames = [ "github.com" ];
        publicKey = "github.com ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMqqnkVzrm0SdG6UOoqKLsabgH5C9okWi0dh2l9GKJl";
      };
      "gitlab.lrz.de" =
      {
        hostNames = [ "gitlab.lrz.de" ];
        publicKey = "gitlab.lrz.de ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIA6zKvHA2x4zmVymuihkY1pfh8cIEAOvJkA44lzuc+Km";
      };
    };
  };
}
