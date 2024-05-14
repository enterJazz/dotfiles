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
        "navigator".psk = "@PSK_NAVIGATOR@";
        "Alpina Dolomites".psk = "@PSK_ALPINA_DOLOMITES@";
        "Ritz-Carlton-Jena".psk = "@PSK_BENE@";
        "SCONTAIN".psk = "@PSK_SCONTAIN@";
      };
      extraConfig =
      ''
        network={
          ssid="FlixTrain Wi-Fi"
        }
        network={
                ssid="eduroam"
                key_mgmt=WPA-EAP
                eap=TTLS
                ca_cert="/etc/ssl/certs/ca-certificates.crt"
                identity="ge32jig@eduroam.mwn.de"
                domain_suffix_match="radius.lrz.de"
                subject_match="radius.lrz.de"
                anonymous_identity="anonymous@eduroam.mwn.de"
                phase2="auth=PAP"
                password="@PSK_EDUROAM@"
        }
      '';
    };
  };
}
