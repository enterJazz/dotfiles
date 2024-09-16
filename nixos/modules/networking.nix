{
  pkgs
  , config
  , lib
  , ... }:
{
  networking =
  {
    wireless =
    {
      enable = true;
      userControlled.enable = true;
      environmentFile = config.sops.secrets.wpa_secrets.path;
      networks =
      {
        "Arnetwork 138".psk = "@PSK_ARNETWORK@";
        "iPhone von Robert".psk = "@PSK_IPHONE@";
        # "navigator".psk = "@PSK_NAVIGATOR@";
        "Alpina Dolomites".psk = "@PSK_ALPINA_DOLOMITES@";
        "Ritz-Carlton-Jena".psk = "@PSK_BENE@";
        "SCONTAIN".psk = "@PSK_SCONTAIN@";
        "TP-Link_1FC7".psk = "@PSK_KONRAD@";
        "WIFIonICE".extraConfig = "key_mgmt=NONE";
        "WIFI@DB".extraConfig = "key_mgmt=NONE";
        # "MeinJena".extraConfig = "key_mgmt=NONE";
        "Netzwerk 123".psk = "@PSK_MARTIN@";
        "FRITZ!Box 6660 Cable TF".psk = "@PSK_WG@";
      };
      extraConfig =
      ''
        network={
                ssid="eduroam"
                key_mgmt=WPA-EAP
                eap=TTLS
                ca_cert="/etc/ssl/certs/ca-certificates.crt"
                identity="@USER_EDUROAM_2@"
                phase2="auth=PAP"
                password="@PSK_EDUROAM_2@"
        }
      '';
    };
  };
}
