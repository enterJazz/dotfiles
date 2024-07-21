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
      hostName = "builder";
      protocol = "ssh-ng";
      sshUser = "nixremote";
      system = "x86_64-linux";
      maxJobs = 64;
      sshKey = config.sops.secrets.dev-vm-robert.path;
      supportedFeatures =
      [
        "big-parallel"
        "kvm"
        "nixos-test"
      ];
    }
  ];

}
