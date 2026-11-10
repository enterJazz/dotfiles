{ pkgs, ... }:
{
  # Rootless: the daemon runs as the user, so access to it is not
  # root-equivalent (unlike membership of the `docker` group).
  # Start with: systemctl --user enable --now docker
  virtualisation.docker.rootless =
  {
    enable = true;
    setSocketVariable = true;
  };
}
