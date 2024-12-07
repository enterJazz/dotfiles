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
      secretsFile = config.sops.secrets.wpa_secrets.path;
      networks =
      {
        "Arnetwork 138".pskRaw = "ext:PSK_ARNETWORK";
        "iPhone von Robert".pskRaw = "ext:PSK_IPHONE";
        "navigator".pskRaw = "ext:PSK_NAVIGATOR";
        "Alpina Dolomites".pskRaw = "ext:PSK_ALPINA_DOLOMITES";
        "Ritz-Carlton-Jena".pskRaw = "ext:PSK_BENE";
        "SCONTAIN".pskRaw = "ext:PSK_SCONTAIN";
        "TP-Link_1FC7".pskRaw = "ext:PSK_KONRAD";
        "WIFIonICE".extraConfig = "key_mgmt=NONE";
        "WIFI@DB".extraConfig = "key_mgmt=NONE";
        "Dresden".extraConfig = "key_mgmt=NONE";
        # "MeinJena".extraConfig = "key_mgmt=NONE";
        "Netzwerk 123".pskRaw = "ext:PSK_MARTIN";
        "FRITZ!Box 6660 Cable TF".pskRaw = "ext:PSK_WG";
      };
      extraConfig =
      ''
        network={
                ssid="eduroam"
                key_mgmt=WPA-EAP
                eap=TTLS
                ca_cert="/etc/ssl/certs/ca-certificates.crt"
                identity="ext:USER_EDUROAM_2"
                phase2="auth=PAP"
                password="ext:PSK_EDUROAM_2"
        }
      '';
    };
  };
}
