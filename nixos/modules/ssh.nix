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
    Host login-tum
      User tunnel
      HostName login.dos.cit.tum.de
      IdentityFile ${config.sops.secrets.dos-cit-tum-de.path}

    Host *.dos.cit.tum.de !login.dos.cit.tum.de
      User robert
      ProxyJump login-tum
      IdentityFile ${config.sops.secrets.dos-cit-tum-de.path}

    Host vislor-builder
      User nix
      ProxyJump login-tum
      HostName vislor.dos.cit.tum.de
      IdentityFile ${config.sops.secrets.remoteBuilder.path}

    Host gitlab.lrz.de
      User git
      IdentityFile ${config.sops.secrets.gitlab-lrz.path}

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
      User robert
      IdentityFile ${config.sops.secrets.dev-vm-robert.path}

    Host scone.cf
      User git
      IdentityFile ${config.sops.secrets.scone-cf.path}
    '';
    knownHosts =
    {
      "login.dos.cit.tum.de" =
      {
        hostNames = [ "login.dos.cit.tum.de" ];
        publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOdlUylM9WIFfIYZDK8rjVYQzX+RYwIlLgsEh4j0pNx6";
      };
      "vislor.dos.cit.tum.de " =
      {
        hostNames = [ "vislor.dos.cit.tum.de" ];
        publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBFKh4D5rTKnC8Jmhuj1SA7a82IG642dXmk38wYdP/lD";
      };
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
