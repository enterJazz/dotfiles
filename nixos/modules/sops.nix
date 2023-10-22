{ pkgs, config, ... }:
{
  # embedd in config files : https://github.com/Mic92/sops-nix#templates
  sops =
  {
    age.keyFile = "/home/robert/.config/sops/age/keys.txt";
    # defaultSopsFile = ./secrets.yaml;
    secrets =
    {
      wpa_secrets =
      {
        sopsFile = ../secrets/wpa_secrets.env;
        format = "dotenv";
        restartUnits = [ "wpa_supplicant.service" ];
      };
    };
  };
}
