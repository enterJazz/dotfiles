# NOTE: possibly helpful: https://alberand.com/nixos-wireguard-vpn.html
{ lib, config, pkgs, ... }:
let
  wgScontainInterface = "wg-scontain";
  vpnServer = "REDACTED";
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
#      DNS=REDACTED
#      Domains=REDACTED REDACTED REDACTED
#    '';
#  };

  networking.wg-quick.interfaces.${wgScontainInterface} = {
    address = [ "REDACTED" ];

#     postSetup =
#     ''
#       resolvectl dns ${wgScontainInterface} REDACTED
#       resolvectl domain ${wgScontainInterface} REDACTED REDACTED REDACTED
#     '';

    mtu = 1280;

    privateKeyFile = config.sops.secrets.wg-scontain-privkey.path;
    peers = [
      {
        allowedIPs = [ "REDACTED" "REDACTED" ];
        # allowedIPs = [ "0.0.0.0/0" ];
        publicKey = "REDACTED";
        endpoint = "${vpnServer}";
        persistentKeepalive = 25;
        presharedKeyFile = config.sops.secrets.wg-scontain-psk.path;
      }
    ];
  };

  # maybe only works for wg-quick?
  systemd.services."wg-quick-${wgScontainInterface}".wantedBy = lib.mkForce [];
}
