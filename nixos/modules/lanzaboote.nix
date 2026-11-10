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
}
