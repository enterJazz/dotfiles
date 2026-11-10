{
  pkgs
  , config
  , ...
}:
{
  # outbound ssh only: no sshd, no open ports
  networking.firewall.enable = true;

  programs.ssh =
  {
    # The host list (names, IPs, users, jump chains) lives sops-encrypted in
    # ../secrets/ssh-hosts; IdentityFile entries there point at /run/secrets/<name>.
    # Edit: sops --input-type binary --output-type binary nixos/secrets/ssh-hosts
    extraConfig =
    ''
      Include ${config.sops.secrets.ssh-hosts.path}
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
