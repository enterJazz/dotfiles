{ pkgs, config, lib, ... }:
{
  # debug + troubleshoot secureboot
  environment.systemPackages = [ pkgs.sbctl ];
  boot.loader.efi.canTouchEfiVariables = false;
  boot.loader.systemd-boot.enable = lib.mkForce false;
  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/etc/secureboot";
  };
}
