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
  # Pin the storage box host key (borg connects on port 23).
  # RSA key fingerprint: SHA256:EMlfI8GsRIfpVkoW1H2u0zYVpFGKkIMKHFZIRkf2ioI
  programs.ssh.knownHosts =
  {
    "u400394.your-storagebox.de" =
    {
      hostNames = [ "[u400394.your-storagebox.de]:23" ];
      publicKey = "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA5EB5p/5Hp3hGW1oHok+PIOH9Pbn7cnUiGmUEBrCVjnAw+HrKyN8bYVV0dIGllswYXwkG/+bgiBlE6IVIBAq+JwVWu1Sss3KarHY3OvFJUXZoZyRRg/Gc/+LRCE7lyKpwWQ70dbelGRyyJFH36eNv6ySXoUYtGkwlU5IVaHPApOxe4LHPZa/qhSRbPo2hwoh0orCtgejRebNtW5nlx00DNFgsvn8Svz2cIYLxsPVzKgUxs8Zxsxgn+Q/UvR7uq4AbAhyBMLxv7DjJ1pc7PJocuTno2Rw9uMZi1gkjbnmiOh6TTXIEWbnroyIhwc8555uto9melEUmWNQ+C+PwAK+MPw==";
    };
  };
}
