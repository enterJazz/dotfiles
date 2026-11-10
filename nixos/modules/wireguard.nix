{ config, pkgs, ... }:
let
  wgInterface = "wg-scontain";
in
{
  environment.systemPackages = with pkgs; [ wireguard-tools ];

  # Endpoint, peer, addresses, routes and DNS all live sops-encrypted:
  # - ../secrets/wg-scontain-conf: a wg-quick config; it loads the private
  #   key and PSK from /run/secrets/wg-scontain-{privkey,psk} in PostUp.
  # - ../secrets/resolved-scontain: a systemd-resolved drop-in.
  # Edit: sops --input-type binary --output-type binary nixos/secrets/<file>
  sops.secrets =
  {
    wg-scontain-conf =
    {
      sopsFile = ../secrets/wg-scontain-conf;
      format = "binary";
    };
    resolved-scontain =
    {
      sopsFile = ../secrets/resolved-scontain;
      format = "binary";
      mode = "0444"; # read by the systemd-resolve user
      restartUnits = [ "systemd-resolved.service" ];
    };
  };

  services.resolved.enable = true;
  environment.etc."systemd/resolved.conf.d/10-vpn.conf".source =
    config.sops.secrets.resolved-scontain.path;

  networking.wg-quick.interfaces.${wgInterface} =
  {
    configFile = config.sops.secrets.wg-scontain-conf.path;
    autostart = config.networking.hostName == "klamm";
  };
}
