# NOTE: possibly helpful: https://alberand.com/nixos-wireguard-vpn.html
{ lib, config, pkgs, ... }:
let
  wgScontainInterface = "wg-scontain";
  scontainVpnServer = "79.242.176.69:9030";
  wgAustriaRestricted = "wg-at-restrict";
in
{
  environment.systemPackages = with pkgs; [ wireguard-tools ];
  
#  services.resolved =
#  {
#    enable = true;
#    extraConfig =
#    ''
#      [Match]
#      Name=${wgScontainInterface}
#
#      [Resolve]
#      DNS=10.50.0.1
#      Domains=~office.scontain ~office.scontain.com ~intranet.scontain.com
#    '';
#  };

  networking.wg-quick.interfaces = {
    ${wgAustriaRestricted} = {
      address = [ "10.73.221.217/32" "fc00:bbbb:bbbb:bb01::a:ddd8/128" ];

      dns = [ "100.64.0.63" ];
      # listenPort = 51820;

      privateKeyFile = config.sops.secrets.wg-mullvad-privkey.path;

      peers = [
        {
          publicKey = "ehXBc726YX1N6Dm7fDAVMG5cIaYAFqCA4Lbpl4VWcWE=";
          allowedIPs = [ "0.0.0.0/0" "::0/0" ];
          endpoint = "146.70.116.130:51820";
          persistentKeepalive = 25;
          # presharedKeyFile = config.sops.secrets.wg-mullvad-psk.path;
        }
      ];
      autostart = if (config.networking.hostName == "barnabas") then true else false;
    };

    ${wgScontainInterface} = {
      address = [ "10.50.0.37/24" ];

#   postSetup =
#   ''
#     resolvectl dns ${wgScontainInterface} 10.50.0.1
#     resolvectl domain ${wgScontainInterface} ~office.scontain ~office.scontain.com ~intranet.scontain.com
#   '';

      mtu = 1280;

      privateKeyFile = config.sops.secrets.wg-scontain-privkey.path;
      peers = [
        {
          allowedIPs = [ "192.168.200.0/21" "10.50.0.0/24" ];
          # allowedIPs = [ "0.0.0.0/0" ];
          publicKey = "3AmSLyD64bUiixYmzMNJ5zQ9dFdMx5jF1QYcr+nz8xo=";
          endpoint = "${scontainVpnServer}";
          persistentKeepalive = 25;
          presharedKeyFile = config.sops.secrets.wg-scontain-psk.path;
        }
      ];
      autostart = if (config.networking.hostName == "klamm") then true else false;
    };
  };

}
