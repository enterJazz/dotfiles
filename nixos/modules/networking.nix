{
  pkgs
  , config
  , lib
  , ... }:
{
# networking
  networking =
  {
    supplicant."robert".configFile.path = "/etc/wpa_supplicant/wpa_supplicant.conf";
    # hostName = "klamm";
    wireless =
    {
      # TODO: fix ; for now use manually
      enable = true;
      userControlled.enable = true;
      environmentFile = config.sops.secrets.wpa_secrets.path;
      networks =
      {
        "Arnetwork 138".psk = "@PSK_ARNETWORK@";
      };
      extraConfig =
      ''
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
