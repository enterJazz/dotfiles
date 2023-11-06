{
  pkgs
  , config
  , ...
}:
{
  programs.ssh =
  {
    extraConfig =
    ''
      Host 146.152.*
        User guest
        IdentityFile ${config.sops.secrets.intel.path}
    '';
  };
}
