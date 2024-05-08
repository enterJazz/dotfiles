{ pkgs, config, ... }:
{
  services.openvpn.servers =
  {
    tudVPN =
    {
      config = '' config /etc/nixos/openvpn/tudVPN.ovpn '';
      updateResolvConf = true;
      autoStart = false;
    };
  };
}
