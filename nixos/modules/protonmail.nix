{ pkgs, ... }:
{
  systemd.services."protonmail-bridge" =
  {
    enable = true;
    description = "protonmail bridge";
    serviceConfig =
    {
      type = "simple";
      ExecStart = ''${pkgs.protonmail-bridge}/bin/protonmail-bridge -n'';
    };
  };
}
