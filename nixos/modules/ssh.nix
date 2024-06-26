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
    Host github.com
      User git
      IdentityFile ${config.sops.secrets.github.path}

    Host u400394.your-storagebox.de
      User u400394
      IdentityFile ${config.sops.secrets.storagebox-ssh.path}

    Host gitlab.office.scontain.com
      User git
      IdentityFile ${config.sops.secrets.gitlab-office-scontain-com.path}

    Host 192.168.20*
      User ubuntu
      IdentityFile ${config.sops.secrets.dev-vm-robert.path}

    Host scone.cf
      User git
      IdentityFile ${config.sops.secrets.scone-cf.path}
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
