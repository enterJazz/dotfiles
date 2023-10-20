{ pkgs, ... }:
{
  systemd.user.services."protonmail-bridge" =
  {
      description = "protonmail bridge";
      serviceConfig =
      {
        type = "simple";
        ExecStart = ''${pkgs.protonmail-bridge}/bin/protonmail-bridge -n'';
      };
  };
}
