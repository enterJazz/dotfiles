{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ pkgs.protonmail-bridge pkgs.pass ];
  services.gnome.gnome-keyring.enable = true;

  # TODO: this is broken ; uses different pass than I do
  # Before starting the service, use `protonmail-bridge --cli` and run 'login'
  # to configure.
  # requires initing pass before ( pass init <gpg-id> )
  systemd.user.services."protonmail-bridge" =
  {
    enable = false;
    description = "Protonmail Bridge";
    after = [ "network.target" ];
    wantedBy = [ "default.target" ];
    # path = [ pkgs.pass ];
    serviceConfig =
    {
      Restart = "always";
      ExecStart = ''${pkgs.protonmail-bridge}/bin/protonmail-bridge --noninteractive'';
    };
  };
}
