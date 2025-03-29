{ config, ... }:
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
      gitlab-office-scontain-com =
      {
        sopsFile = ../secrets/keys/gitlab.office.scontain.com;
        format = "binary";
        owner = config.users.users.robert.name;
      };
      gitlab-lrz =
      {
        sopsFile = ../secrets/keys/gitlab.lrz.de;
        format = "binary";
        owner = config.users.users.robert.name;
      };
      github =
      {
        sopsFile = ../secrets/keys/github.com;
        format = "binary";
        owner = config.users.users.robert.name;
      };
      dos-cit-tum-de =
      {
        sopsFile = ../secrets/keys/dos.cit.tum.de;
        format = "binary";
        owner = config.users.users.robert.name;
      };
      storagebox-ssh =
      {
        sopsFile = ../secrets/keys/u400394.your-storagebox.de;
        format = "binary";
        owner = config.users.users.robert.name;
      };
      wg-scontain-privkey =
      {
        sopsFile = ../secrets/keys/wg-scontain-privkey;
        format = "binary";
        owner = config.users.users.robert.name;
      };
      wg-scontain-psk =
      {
        sopsFile = ../secrets/keys/wg-scontain-psk;
        format = "binary";
        owner = config.users.users.robert.name;
      };
      wg-mullvad-privkey =
      {
        sopsFile = ../secrets/keys/wg-mullvad;
        format = "binary";
        owner = config.users.users.robert.name;
      };
      wg-mullvad-psk =
      {
        sopsFile = ../secrets/keys/wg-mullvad-psk;
        format = "binary";
        owner = config.users.users.robert.name;
      };
      dev-vm-robert =
      {
        sopsFile = ../secrets/keys/dev-vm-robert;
        format = "binary";
        owner = config.users.users.robert.name;
      };
      scone-cf =
      {
        sopsFile = ../secrets/keys/scone.cf;
        format = "binary";
        owner = config.users.users.robert.name;
      };
      sconecf-gitlab-icelake-runner-9-robert-nixos =
      {
        sopsFile = ../secrets/keys/sconecf-gitlab-icelake-runner-9-robert-nixos;
        format = "binary";
        owner = config.users.users.robert.name;
      };
      tud-vm = {
        sopsFile = ../secrets/keys/maas;
        format = "binary";
        owner = config.users.users.robert.name;
      };
      beast = {
        sopsFile = ../secrets/keys/beast;
        format = "binary";
        owner = config.users.users.robert.name;
      };
      tud-se-gitlab = {
        sopsFile = ../secrets/keys/se-gitlab.inf.tu-dresden.de;
        format = "binary";
        owner = config.users.users.robert.name;
      };
      hetzner = {
        sopsFile = ../secrets/keys/hetzner;
        format = "binary";
        owner = config.users.users.robert.name;
      };
    };
  };
}
