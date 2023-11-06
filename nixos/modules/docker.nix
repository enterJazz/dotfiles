{ pkgs, ... }:
{
  virtualisation.docker.enable = true;
  users.users.robert.extraGroups = [ "docker" ];
}
