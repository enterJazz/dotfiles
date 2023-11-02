{ pkgs, ... }:
{
  # TODO: fix -> can't open sercret vault
  systemd.user.services."protonmail-bridge" =
  {
    enable = false;
    description = "protonmail bridge";
    serviceConfig =
    {
      ExecStart = ''${pkgs.protonmail-bridge}/bin/protonmail-bridge -n'';
    };
  };
}
