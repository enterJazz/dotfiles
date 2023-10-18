{ pkgs, config, ... }:
{
  # embedd in config files : https://github.com/Mic92/sops-nix#templates
  sops =
  {
    age.keyFile = "/home/robert/.config/sops/keys.txt";
    # defaultSopsFile = ./secrets.yaml;
    secrets =
    {
      wpa_supplicant =
      {
        sopsFile = ../secrets/wpa_secrets.yaml;
        restartUnits = [ "wpa_supplicant.service" ];
      };
    };
  };

  # templates
  sops.templates =
  {
    "wpa_supplicant.conf".content =
    ''

    '';
  };
}
