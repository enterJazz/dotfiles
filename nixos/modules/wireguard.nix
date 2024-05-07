{ config, pkgs, ... }:
let
  wgScontainInterface = "wg-scontain";
in
{
  environment.systemPackages = with pkgs; [ wireguard-tools ];
  
  services.resolved =
  {
    enable = true;
    extraConfig =
    ''
      [Match]
      Name=${wgScontainInterface}

      [Resolve]
      DNS=REDACTED
      Domains=REDACTED REDACTED REDACTED
    '';
  };

  networking.wireguard.interfaces.${wgScontainInterface} = {
    ips = [ "REDACTED" ];

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
        endpoint = "REDACTED";
        presharedKeyFile = config.sops.secrets.wg-scontain-psk.path;
      }
    ];
  };
}
