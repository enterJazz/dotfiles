{ config, lib, ... }:
{
  # Offload builds to a remote machine. `sgx19-jump` is an alias from the
  # encrypted ssh host list (../secrets/ssh-hosts), which also supplies user,
  # key and jump hosts. The nix daemon connects as root, so the host keys of
  # the whole jump chain are pinned system-wide from an encrypted file.
  sops.secrets.ssh-known-hosts =
  {
    sopsFile = ../secrets/ssh-known-hosts;
    format = "binary";
    mode = "0444";
  };
  # must come before any Host block; the first value wins over the default
  programs.ssh.extraConfig = lib.mkBefore
  ''
    GlobalKnownHostsFile /etc/ssh/ssh_known_hosts ${config.sops.secrets.ssh-known-hosts.path}
  '';

  nix.distributedBuilds = true;
  nix.buildMachines =
  [
    {
      # nix is not on the non-interactive PATH there (Ubuntu, multi-user install)
      hostName = "sgx19-jump?remote-program=/nix/var/nix/profiles/default/bin/nix-daemon";
      protocol = "ssh-ng";
      system = "x86_64-linux";
      maxJobs = 16;
      speedFactor = 4;
      supportedFeatures =
      [
        "big-parallel"
        "kvm"
        "nixos-test"
        "benchmark"
      ];
    }
  ];

  nix.settings =
  {
    # let the builder fetch dependencies from the binary cache itself
    builders-use-substitutes = true;
    # builder unreachable (e.g. off the university network): give up quickly
    # and build on this machine instead
    connect-timeout = 5;
    fallback = true;
  };
}
