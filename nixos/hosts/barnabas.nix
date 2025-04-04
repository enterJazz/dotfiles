# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{
  pkgs
  , ...
}:

{
  imports =
  [
    # ../modules/fuse.nix
    # ../modules/passwordstore.nix
    # ../modules/protonmail.nix
    ../modules/wireguard.nix
    ../hardware/hardware-configuration.nix
    ../modules/bluetooth.nix
    ../modules/borgbackup.nix
    ../modules/docker.nix
    ../modules/fonts.nix
    ../modules/fwupd.nix
    ../modules/greetd.nix
    ../modules/lanzaboote.nix
    ../modules/networking.nix
    ../modules/openvpn.nix
    ../modules/pipewire.nix
    # ../modules/remote-builder.nix
    ../modules/sops.nix
    ../modules/ssh.nix
    ../modules/xournalpp.nix
    ../modules/xournalpp.nix
    ../modules/zsh.nix
  ];

  nix =
  {
    package = pkgs.nixVersions.stable;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   # keyMap = "us";
  #   useXkbConfig = true; # use xkbOptions in tty.
  # };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  users =
  {
    defaultUserShell = pkgs.zsh;
    users.robert =
    {
      uid = 1001;
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "video"
        "audio"
        # config.users.groups.keys.age
      ]; # Enable ‘sudo’ for the user.
    };
  };
  
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # environment.systemPackages = with pkgs; [
  #   vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #   wget
  # ];
  environment =
  {
    shells = [ pkgs.zsh ];
    variables.EDITOR = "nvim";
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # programs that have to be enabled in config
  programs =
  {
    zsh.enable = true;
    light.enable = true;
  };

  # List services that you want to enable:
  services =
  {
    keyd =
    {
      enable = true;
      keyboards.default.settings =
      {
        main.delete = "off";
      };
    };
    pipewire.enable = true;
  };

  xdg =
  {
    portal =
    {
      enable = true;
      extraPortals = with pkgs;
      [
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gtk
      ];
      config.common.default = "*";
    };
  };


  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  system.stateVersion = "24.05";
  
  boot.loader =
  {
#     grub =
#     {
#       enable = true;
#       device = "nodev";
#       efiSupport = true;
#     };
    efi =
    {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
  };

  security =
  {
    polkit.enable = true;
    pam.services.swaylock.fprintAuth = false;
  };
  

  systemd = 
  { 
    # from nixos.wiki/wiki/Sway
    user.services.kanshi =
    {
      description = "kanshi daemon";
      serviceConfig =
      {
        type = "simple";
        ExecStart = ''${pkgs.kanshi}/bin/kanshi -c kanshi_config_file'';
      };
    };
  };

  # from drakerossman.com/blog/wayland-on-nixos-confusion-conquest-triumph
  # audio
  # sound.enable = true; -> removed in 24.11
  # hardware.pulseaudio.enable = true;
  hardware.graphics.enable = true;

  networking.hostName = "barnabas";

  # try to enable sgx by updating kernel
  boot.kernelPackages = pkgs.linuxPackages_6_6;
}

