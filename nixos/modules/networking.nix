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
#       extraConfig =
#       ''
#         network={
#                 ssid="Arnetwork 138"
#                 psk=${config.sops.wpa_secrets.arnetwork_138_psk}
#         }
#         network={
#                 ssid="eduroam"
#                 key_mgmt=WPA-EAP
#                 eap=TTLS
#                 ca_cert="/etc/ssl/certs/ca-certificates.crt"
#                 identity="ge32jig@eduroam.mwn.de"
#                 domain_suffix_match="radius.lrz.de"
#                 subject_match="radius.lrz.de"
#                 anonymous_identity="anonymous@eduroam.mwn.de"
#                 phase2="auth=PAP"
#                 password="${config.sops.wpa_supplicant.eduroam_password}"
#         }
#       '';
    };
  };

  systemd.services.wpa_supplicant =
  {
    enable = false;
    serviceConfig =
    {
      # SupplementaryGroups = [ config.users.groups.keys.age ];
    };
  };
}
