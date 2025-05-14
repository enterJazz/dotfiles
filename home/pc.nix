{ pkgs, lib, ... }:
{
  imports =
  [
    ./common/linux.nix
    ./modules/direnv.nix
    ./modules/foot.nix
    ./modules/fzf.nix
    ./modules/git.nix
    ./modules/neovim.nix
    ./modules/tmux.nix
    ./modules/tofi.nix
    ./modules/waybar.nix
    ./modules/zsh.nix
  ];

  home = {
    packages = with pkgs;
    [
      # teams
      # authy -> EOL 24.05
      # slack
      # telegram-desktop
      bitwarden
      brave
      cpuid
      ctags
      dig
      docker-compose
      drawio
      evince
      ferdium
      # firefox-wayland
      foliate
      # google-chrome
      jq
      htop
      libreoffice
      light
      nautilus
      neofetch
      nextcloud-client
      obsidian
      openvpn
      ollama
      pavucontrol
      playerctl
      rename
      shotman
      shotwell
      signal-desktop
      sshpass
      thunderbird
      vscode-fhs
      wdisplays
      wireguard-tools
      wl-clipboard
      wlsunset
      xournalpp
      zathura
      zoom-us
      zotero_7
    ];

    sessionVariables =
    {
      MOZ_ENABLE_WAYLAND = 1;
      XDG_CURRENT_DESKTOP = "sway";
    };
  };

  programs =
  {
    firefox =
    {
      enable = true;
      profiles.robert =
      {
        name = "robert";
        id = 0;
        search =
        {
          default = "ddg";
          force = true;
          engines =
          {
            "Investopedia" =
            {
              urls = [{ template = "https://www.investopedia.com/search?q={searchTerms}"; }];
              icon = "https://upload.wikimedia.org/wikipedia/commons/3/37/Investopedia_Logo.svg";
              definedAliases = [ "@invest" ];
            };
            "Google Scholar" =
            {
              urls = [{ template = "https://scholar.google.com/scholar?hl=en&q={searchTerms}"; }];
              icon = "https://upload.wikimedia.org/wikipedia/commons/c/c7/Google_Scholar_logo.svg";
              definedAliases = [ "@scholar" ];
            };
            "GitHub" =
            {
              urls = [{ template = "https://github.com/search?q={searchTerms}&type=repositories"; }];
              icon = "https://upload.wikimedia.org/wikipedia/commons/9/95/Font_Awesome_5_brands_github.svg";
              definedAliases = [ "@gh" ];
            };
            "Nix Packages" =
            {
              urls =
              [{
                  template = "https://search.nixos.org/packages";
                  params =
                  [
                      { name = "type"; value = "packages"; }
                      { name = "query"; value = "{searchTerms}"; }
                  ];
              }];
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = [ "@np" ];
            };
            "NixOS Wiki" =
            {
              urls = [{ template = "https://wiki.nixos.org/w/index.php?search={searchTerms}"; }];
              icon = "https://wiki.nixos.org/nixos.png";
              updateInterval = 24 * 60 * 60 * 1000;
              definedAliases = [ "@nw" ];
            };
            "wikipedia".metaData.alias = "@wiki";
            "google".metaData.hidden = true;
            "amazondotcom-us".metaData.hidden = true;
            "bing".metaData.hidden = true;
            "ebay".metaData.hidden = true;
          };
        };
        settings =
        {
          "browser.startup.homepage" = "https://nixos.org";
          "browser.search.region" = "DE";
          "browser.search.isUS" = false;
          "distribution.searchplugins.defaultLocale" = "de-DE";
          "general.useragent.locale" = "de-DE";
          "browser.bookmarks.showMobileBookmarks" = false;
          "browser.toolbars.bookmarks.showOtherBookmarks" = false;
          "browser.compactmode.show" = true;
          "browser.newtabpage.pinned" = [{
            title = "NixOS";
            url = "https://nixos.org";
          }];
          "extensions.pocket.enabled" = false;
        };
        extensions = with pkgs.nur.repos.rycee.firefox-addons;
        [
          ublock-origin
          privacy-badger
          bitwarden
          clearurls
          decentraleyes
        ];
        isDefault = true;
      };
    };

    zathura =
    {
      enable = true;
    };
    swaylock =
    {
      enable = true;
      settings =
      {
        color = "808080";
        font-size = 24;
        indicator-idle-visible = false;
        indicator-radius= 100;
        line-color = "ffffff";
        show-failed-attempts = true;
      };
    };
  };


  # from nixos.wiki/wiki/Sway
  wayland.windowManager.sway =
  let
    mod = "Mod4";
    alt = "Mod1";
  in
  {
    enable = true;
    config = rec
    {
      # bars by waybar
      bars = [];
      modifier = "${mod}";
      output =
      {
        "Virtual-1" =
	{
	  mode = "1920x1080@60Hz";
	};
      };
      keybindings =
      lib.mkOptionDefault
      {
        # Lock
        "${mod}+Shift+semicolon" = "exec swaylock -c 000000";
        # Dismiss notifications
        "${mod}+Escape" = "exec makoctl dismiss";
        # Volume
        "XF86AudioMute" = "exec pactl set-sink-mute @DEFAULT_SINK@ toggle";
        "XF86AudioLowerVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ -5%";
        "XF86AudioRaiseVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ +5%";
        # Audio input
        # NOTE: XF86AudioMicMute is not the correct key?
        # https://github.com/qmk/qmk_firmware/issues/17749 ?
        "XF86AudioMicMute" = "exec pactl set-source-mute @DEFAULT_SOURCE@ toggle";
        # Brightness
        "XF86MonBrightnessDown" = "exec light -U 5";
        "XF86MonBrightnessUp" = "exec light -A 5";
        # Control audio
        "XF86AudioPlay" = "exec playerctl play-pause";
        "XF86AudioNext" = "exec playerctl next";
        "XF86AudioPrev" = "exec playerctl previous";

        # rotate current display
        "${mod}+Shift+r" = "exec swaymsg output $(swaymsg -t get_outputs | jq -r '.[] | select(.focused == true) | .name') transform 90 clockwise";
      };
    };
    extraConfig =
    ''
      bindsym Print exec shotman -c output
      bindsym Print+Shift exec shotman -c region
      bindsym Print+Shift+Control exec shotman -c window
    '';
    systemd.enable = true;
  };

  
  services =
  {
    nextcloud-client =
    {
      enable = true;
      startInBackground = true;
    };
    mako =
    {
      enable = true;
      settings =
      {
        actions = true;
        anchor = "top-right";
        background-color = "#000000";
        border-color = "#FFFFFF";
        border-radius = 0;
        default-timeout = 0;
        font = "monospace 10";
        height = 100;
        width = 300;
        icons = true;
        ignore-timeout = false;
        layer = "top";
        margin = 10;
        markup = true;
      };
    };
  };
}
