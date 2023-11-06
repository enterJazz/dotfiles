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
      # host list removed from history; now in the sops secret ssh-hosts
    '';
        # ProxyCommand ${pkgs.netcat.bin.nc} -x 
  };
}
