# NOTE: possibly helpful: https://alberand.com/nixos-wireguard-vpn.html
# interesting multi-setup: https://github.com/LongerHV/nixos-configuration/blob/5f7a9336f564968c82eed59e59132d92c05c0ff5/nixos/mordor/vpn.nix
{ lib, config, pkgs, ... }:
let
  wgScontainInterface = "wg-scontain";
  scontainVpnServer = "REDACTED";
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
        DNS = "REDACTED";
        Domains = "REDACTED REDACTED REDACTED";
      };
    };
  };

  networking.wg-quick.interfaces = {
#    ${wgAustriaRestricted} = {
#      address = [ "REDACTED" "REDACTED" ];
#
#      dns = [ "REDACTED" ];
#
#      # listenPort = 51820;
#
#      privateKeyFile = config.sops.secrets.wg-mullvad-privkey.path;
#
#      peers = [
#        {
#          publicKey = "REDACTED";
#          allowedIPs = [ "0.0.0.0/0" "::0/0" ];
#          endpoint = "REDACTED";
#          persistentKeepalive = 25;
#        }
#      ];
#      # autostart = if (config.networking.hostName == "barnabas") then true else false;
#    };

    ${wgScontainInterface} = {
      address = [
        "REDACTED"
        "fdfa:4029:e9e1:2965::7/128"
      ];

       postUp =
       ''
         resolvectl dns ${wgScontainInterface} REDACTED fdfa:4029:e9e1:2965::1
         resolvectl domain ${wgScontainInterface} REDACTED REDACTED REDACTED
       '';

      mtu = 1280;

      privateKeyFile = config.sops.secrets.wg-scontain-privkey.path;
      peers = [
        {
          allowedIPs = [ "0.0.0.0/0" "::/0" ];
          # allowedIPs = [ "0.0.0.0/0" ];
          publicKey = "REDACTED";
          endpoint = "${scontainVpnServer}";
          persistentKeepalive = 25;
          presharedKeyFile = config.sops.secrets.wg-scontain-psk.path;
        }
      ];
      autostart = if (config.networking.hostName == "klamm") then true else false;
    };
  };

}
