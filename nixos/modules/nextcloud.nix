{
  pkgs
  , config
  , ...
}:
{
  services.davfs2 =
  {
    enable = true;
    extraConfig =
    ''
      # NextCloud does not support locks
      use_locks 0
    '';
  };

  users.users.robert.extraGroups = [config.services.davfs2.davGroup];

  services.autofs =
  {
    enable = true;
    autoMaster =
      let
        davfsConf = pkgs.writeText "davfs2.conf"
        ''
          secrets ${config.sops.secrets.davfs_nextcloud.path}
        '';

        uid = toString config.users.users.robert.uid;

        mapConf = pkgs.writeText "autofs.mnt"
        ''
          nextcloud \
            -fstype=davfs,uid=${uid},file_mode=600,dir_mode=700,conf=${davfsConf},rw \
            :https\://nextcloud.in.tum.de/remote.php/dav/files/scha
        '';
      in
      # PLEASE DO NOT MOUNT THIS ON HOMEDIR, YOU WILL BE IN GREAT PAIN
      ''
        ${config.users.users.robert.home}/mount  ${mapConf}  --timeout 60 --ghost --debug
      '';
  };
}
