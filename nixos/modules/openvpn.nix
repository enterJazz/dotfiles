{ pkgs, config, ... }:
{
  services.openvpn.servers =
  {
    tudVPN =
    {
      config = '' config /etc/nixos/openvpn/tudVPN.ovpn '';
      autoStart = false;
    };
  };
}
