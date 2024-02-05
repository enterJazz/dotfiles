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
    Host thesissshserver
      HostName 146.152.205.66
      User guest
      IdentityFile ${config.sops.secrets.thesis.path}

    Host sdp
      HostName 192.168.6.2
      User sdp
      ProxyCommand ssh -W %h:%p thesissshserver
      LocalForward 10443 192.168.6.3:443
      LocalForward 10022 192.168.6.4:22
      IdentityFile ${config.sops.secrets.thesis.path}

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
