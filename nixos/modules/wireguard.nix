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
      DNS=10.50.0.1
      Domains=~office.scontain ~office.scontain.com ~intranet.scontain.com
    '';
  };

  networking.wireguard.interfaces.${wgScontainInterface} = {
    ips = [ "10.50.0.37/24" ];

#     postSetup =
#     ''
#       resolvectl dns ${wgScontainInterface} 10.50.0.1
#       resolvectl domain ${wgScontainInterface} ~office.scontain ~office.scontain.com ~intranet.scontain.com
#     '';

    mtu = 1280;

    privateKeyFile = config.sops.secrets.wg-scontain-privkey.path;
    peers = [
      {
        allowedIPs = [ "192.168.200.0/21" "10.50.0.0/24" ];
        # allowedIPs = [ "0.0.0.0/0" ];
        publicKey = "3AmSLyD64bUiixYmzMNJ5zQ9dFdMx5jF1QYcr+nz8xo=";
        endpoint = "vpn.scontain.com:9030";
        presharedKeyFile = config.sops.secrets.wg-scontain-psk.path;
      }
    ];
  };
}
