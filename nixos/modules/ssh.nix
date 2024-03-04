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
