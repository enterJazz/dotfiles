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
  # TODO: probably move hm-ssh into nixos ssh
  programs.ssh =
  {
    extraConfig =
    ''
      # host list removed from history; now in the sops secret ssh-hosts
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
    };
  };
}
