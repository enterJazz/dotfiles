# NOTE: possibly helpful: https://alberand.com/nixos-wireguard-vpn.html
# interesting multi-setup: https://github.com/LongerHV/nixos-configuration/blob/5f7a9336f564968c82eed59e59132d92c05c0ff5/nixos/mordor/vpn.nix
{ lib, config, pkgs, ... }:
let
  wgScontainInterface = "wg-scontain";
  scontainVpnServer = "vpn.scontain.com:51820";
  wgAustriaRestricted = "wg-at-restrict";
in
{
  environment.systemPackages = with pkgs; [ wireguard-tools ];
  
  services.resolved =
  {
    enable = true;
    settings = {
      #Match =
      #{
      #  Name = wgScontainInterface;
      #};
      Resolve =
      {
        DNS = "10.50.0.1";
        Domains = "~office.scontain ~office.scontain.com ~intranet.scontain.com";
      };
    };
  };

  networking.wg-quick.interfaces = {
#    ${wgAustriaRestricted} = {
#      address = [ "10.73.221.217/32" "fc00:bbbb:bbbb:bb01::a:ddd8/128" ];
#
#      dns = [ "100.64.0.63" ];
#
#      # listenPort = 51820;
#
#      privateKeyFile = config.sops.secrets.wg-mullvad-privkey.path;
#
#      peers = [
#        {
#          publicKey = "ehXBc726YX1N6Dm7fDAVMG5cIaYAFqCA4Lbpl4VWcWE=";
#          allowedIPs = [ "0.0.0.0/0" "::0/0" ];
#          endpoint = "146.70.116.130:51820";
#          persistentKeepalive = 25;
#        }
#      ];
#      # autostart = if (config.networking.hostName == "barnabas") then true else false;
#    };

    ${wgScontainInterface} = {
      address = [ "10.99.100.18/32" ];

       postUp =
       ''
         resolvectl dns ${wgScontainInterface} 10.99.100.1
         resolvectl domain ${wgScontainInterface} ~office.scontain ~office.scontain.com ~intranet.scontain.com
       '';

      mtu = 1280;

      privateKeyFile = config.sops.secrets.wg-scontain-privkey.path;
      peers = [
        {
          allowedIPs = [ "192.168.200.0/21" "10.99.0.0/16" ];
          # allowedIPs = [ "0.0.0.0/0" ];
          publicKey = "xu0Avv8DaxWpfcyZQSbo87lL2ccQTgDZNHkf0e9wvz8=";
          endpoint = "${scontainVpnServer}";
          persistentKeepalive = 25;
          presharedKeyFile = config.sops.secrets.wg-scontain-psk.path;
        }
      ];
      autostart = if (config.networking.hostName == "klamm") then true else false;
    };
  };

}
