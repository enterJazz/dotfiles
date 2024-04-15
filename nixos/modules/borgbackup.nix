{ pkgs, config, ... }:
{
  # I stole this from Joerg
  
  environment.systemPackages = with pkgs; [ curl ];
  services.borgbackup.jobs.home-robert =
  {
    paths =
    [
      "/home"
      "/etc"
      "/var"
      "/root"
    ];
    exclude =
    [
      "*.pyc"
      "/home/*/.direnv"
      "/home/*/.cache"
      "/home/*/.npm"
      "/home/*/.m2"
      "/home/*/.gradle"
      "/home/*/.opam"
      "/home/*/.clangd"
      "/home/*/.config/Ferdium/Partitions"
      "/home/*/.mozilla/firefox/*/storage"
      "/home/*/Android"
      "/var/lib/containerd"
      # already included in database backup
      "/var/lib/postgresql"
      # not so important
      "/var/db/influxdb"
      "/var/lib/docker/"
      "/var/log/journal"
      "/var/lib/containerd"
      "/var/lib/systemd" # not so interesting state so far
      "/var/cache"
      "/var/tmp"
      "/var/log"
      "/home/robert/mount"
    ];
    encryption =
    {
      mode = "repokey";
      passCommand = "cat ${config.sops.secrets."${config.networking.hostName}-borgbackup-passphrase".path}";
    };
    environment.BORG_RSH = "ssh -p23 -i ${config.sops.secrets."${config.networking.hostName}-borgbackup-ssh".path}";
    repo = "u400394@u400394.your-storagebox.de:backups/${config.networking.hostName}::${config.networking.hostName}";
    compression = "auto,zstd";
    startAt = "daily";
    prune.keep =
    {
      within = "1d"; # Keep all archives from the last day
      daily = 7;
      weekly = 4;
      monthly = 0;
    };
    postHook =
    ''
      if [[ $exitStatus -eq 0 ]] ; then
        ${pkgs.curl}/bin/curl $(cat ${config.sops.secrets."${config.networking.hostName}-borgbackup-healthchecks".path})
      fi
    '';
  };
  # NOTE: ssh used different knownHosts config and ignored this, causing borg
  # setup to fail
  programs.ssh.knownHosts =
  {
    "borgbackup.cit.tum.de" =
    {
      hostNames = [ "borgbackup.cit.tum.de" ];
      publicKey = "SHA256:qp2UT3bAeh4LAB6jYBR1Ij9oTa8edCNR4w2n4s7whts";
    };
    "u400394.your-storagebox.de" =
    {
      hostNames = [ "u400394.your-storagebox.de" ];
      publicKey = "SHA256:EMlfI8GsRIfpVkoW1H2u0zYVpFGKkIMKHFZIRkf2ioI";
    };
  };
}
