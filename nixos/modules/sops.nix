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
      remoteBuilder =
      {
        sopsFile = ../secrets/remote-doctor-builder-key;
        format = "binary";
      };
      davfs_nextcloud =
      {
        sopsFile = ../secrets/davfs_nextcloud;
        # owner = config.users.users.robert.name;
        # group = config.services.davfs2.davGroup;
        format = "binary";
      };
      # borgbackup secrets
      klamm-borgbackup-passphrase =
      {
        sopsFile = ../secrets/klamm/borgbackup-passphrase;
        format = "binary";
      };
      klamm-borgbackup-ssh =
      {
        sopsFile = ../secrets/klamm/borgbackup-ssh-key;
        format = "binary";
      };
      klamm-borgbackup-healthchecks =
      {
        sopsFile = ../secrets/klamm/borgbackup-healthchecks;
        format = "binary";
      };
      barnabas-borgbackup-passphrase =
      {
        sopsFile = ../secrets/barnabas/borgbackup-passphrase;
        format = "binary";
      };
      barnabas-borgbackup-ssh =
      {
        sopsFile = ../secrets/barnabas/borgbackup-ssh-key;
        format = "binary";
      };
      barnabas-borgbackup-healthchecks =
      {
        sopsFile = ../secrets/barnabas/borgbackup-healthchecks;
        format = "binary";
      };

      intel =
      {
        sopsFile = ../secrets/intel;
        format = "binary";
      };
    };
  };
}
