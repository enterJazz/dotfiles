{ config, ... }:
{
  # I stole this from Joerg and Peter
  # corresponding sshconf in home manager
  nix.distributedBuilds = true;
  nix.extraOptions = '' builders-use-substitutes = true '';
  nix.buildMachines =
  [
    {
      # speedFactor = 0;
      hostName = "vislor";
      protocol = "ssh";
      sshUser = "nix";
      system = "x86_64-linux";
      maxJobs = 64;
      # TODO replace w/ sops
      sshKey = config.sops.secrets.remoteBuilder.path;
      supportedFeatures =
      [
        "big-parallel"
        "kvm"
        "nixos-test"
      ];
    }
  ];

}
