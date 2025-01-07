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

    Host se-gitlab.inf.tu-dresden.de
      User git
      IdentityFile ${config.sops.secrets.tud-se-gitlab.path}

    Host sconecf.office.scontain.com
      User git
      IdentityFile ${config.sops.secrets.scone-cf.path}

    Host 192.168.205.190
      User root
      IdentityFile ${config.sops.secrets.sconecf-gitlab-icelake-runner-9-robert-nixos.path}

    Host work-dev-vm
      User robert
      HostName 192.168.205.120
      IdentityFile ${config.sops.secrets.dev-vm-robert.path}

    Host work-dev-vm-ubuntu
      User ubuntu
      HostName 192.168.205.120
      IdentityFile ${config.sops.secrets.dev-vm-robert.path}

    Host 192.168.20*
      User ubuntu
      IdentityFile ${config.sops.secrets.dev-vm-robert.path}

    Host scone.cf
      User git
      IdentityFile ${config.sops.secrets.scone-cf.path}

    Host builder
      User nixremote
      HostName 192.168.205.120
      IdentityFile ${config.sops.secrets.dev-vm-robert.path}

    Host beast
      User rschambach
      HostName 141.76.44.200
      IdentityFile ${config.sops.secrets.beast.path}

    Host tud-vm-jump
      User robert
      HostName 141.76.44.114
      IdentityFile ${config.sops.secrets.tud-vm.path}
      ProxyJump beast

    Host tud-vm
      User robert
      HostName 141.76.44.114
      IdentityFile ${config.sops.secrets.tud-vm.path}

    Host tud-vm-temp
      User ubuntu
      HostName 141.76.44.113
      IdentityFile ${config.sops.secrets.tud-vm.path}
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
