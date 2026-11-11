{ pkgs, lib, ... }:
{
  # Secure Boot via lanzaboote: systemd-boot plus kernels/initrds signed with
  # our own keys. One-time setup per machine:
  #   sudo sbctl create-keys                 # before the first rebuild
  #   sudo sbctl verify                      # after rebuild + reboot
  #   (firmware: reset Secure Boot to Setup Mode)
  #   sudo sbctl enroll-keys --microsoft     # then enable Secure Boot
  environment.systemPackages = [ pkgs.sbctl ];

  boot.loader =
  {
    # lanzaboote replaces the systemd-boot module
    systemd-boot.enable = lib.mkForce false;
    # needed so the firmware gets a boot entry for systemd-boot
    efi.canTouchEfiVariables = true;
  };

  boot.lanzaboote =
  {
    enable = true;
    pkiBundle = "/var/lib/sbctl";
    # /boot is small; each generation costs a kernel + initrd
    configurationLimit = 4;
  };

  # lanzaboote signs fwupd-efi into /run/fwupd-efi and points the daemon there
  # with FWUPD_EFIAPPDIR, but fwupd 2.1.x no longer reads that variable, so
  # firmware updates fail under Secure Boot ("fwupdx64.efi.signed cannot be
  # found"). Build fwupd from a fork branch (release 2.1.4 + one commit) that
  # restores the override. Drop once fwupd or lanzaboote fix this upstream.
  services.fwupd.package = pkgs.fwupd.overrideAttrs (old:
  {
    src = pkgs.fetchFromGitHub
    {
      owner = "enterJazz";
      repo = "fwupd";
      rev = "0ff552ee372151e50f49d67bd7f818a7ab42667a"; # branch efiappdir-env-2.1.4
      hash = "sha256-dUVrKPq7e9Ye9m79YqW+Jl/KXj2w0/OMNwSGR1+7Q6k=";
    };
  });
}
