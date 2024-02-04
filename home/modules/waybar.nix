{ pkgs, ... }:
{
  programs.waybar =
    {
      enable = true;
      systemd =
      {
        enable = true;
        target = "sway-session.target";
      };
      settings =
      {
        mainBar =
        {
          "layer" = "top";
          "position" = "bottom";

          modules-left =
          [
            "sway/workspaces"
            "custom/right-arrow-dark"
          ];
          modules-center =
          [
            "custom/left-arrow-dark"
            "clock#1"
            "custom/left-arrow-light"
            "custom/left-arrow-dark"
            "clock#2"
            "custom/right-arrow-dark"
            "custom/right-arrow-light"
            "clock#3"
            "custom/right-arrow-dark"
          ];
          modules-right =
          [
            "custom/left-arrow-dark"
            "network"
            "custom/left-arrow-light"
            "custom/left-arrow-dark"
            "pulseaudio"
            "custom/left-arrow-light"
            "custom/left-arrow-dark"
            # "memory"
            # "custom/left-arrow-light"
            # "custom/left-arrow-dark"
            # "cpu"
            # "custom/left-arrow-light"
            # "custom/left-arrow-dark"
            "battery"
            "custom/left-arrow-light"
            "custom/left-arrow-dark"
            "disk"
            "custom/left-arrow-light"
            "custom/left-arrow-dark"
            "tray"
          ];

          "custom/left-arrow-dark" =
          {
            "format" = "";
            "tooltip" = false;
          };
          "custom/left-arrow-light" =
          {
            "format" = "";
            "tooltip" = false;
          };
          "custom/right-arrow-dark" =
          {
            "format" = "";
            "tooltip" = false;
          };
          "custom/right-arrow-light" =
          {
            "format" = "";
            "tooltip" = false;
          };

          "sway/workspaces" =
          {
            "disable-scroll" = true;
            "format" = "{name}";
          };

          "clock#1" =
          {
            "format" = "{:%a}";
            "tooltip" = false;
          };
          "clock#2" =
          {
            "format" = "{:%H:%M}";
            "tooltip" = false;
          };
          "clock#3" =
          {
            "format" = "{:%m-%d}";
            "tooltip" = false;
          };

          network =
          {
            "format-wifi" = "{icon} {essid}";
            "format-ethernet" = " {ifname}: {ipaddr}/{cidr}";
            "format-disconnected" = "⚠ Disconnected";
            "interval" = 7;
            "format-icons" = {
              "default" = "";
            };
          };
          pulseaudio = {
                  "format" = "{icon} {volume:2}%";
                  "format-bluetooth" = "{icon}  {volume}%";
                  "format-muted" = "MUTE";
                  "format-icons" = {
                          "headphones" = "";
                          "default" =
                          [
                                  ""
                                  ""
                          ];
                  };
                  "scroll-step" = 5;
                  "on-click" = "pamixer -t";
                  "on-click-right" = "pavucontrol";
          };
          "memory" = {
                  "interval" = 5;
                  "format" = "Mem {}%";
          };
          "cpu" = {
                  "interval" = 5;
                  "format" = "CPU {usage:2}%";
          };
          "battery" = {
                  "states" = {
                          "good" = 95;
                          "warning" = 30;
                          "critical" = 15;
                  };
                  "format" = "{icon} {capacity}%";
                  "format-icons" = [
                          ""
                          ""
                          ""
                          ""
                          ""
                  ];
          };
          "disk" = {
                  "interval" = 5;
                  "format" = "Disk {percentage_used:2}%";
                  "path" = "/";
          };
          "tray" = {
                  "icon-size" = 20;
          };
        };
      };
      style =
      ''
      * {
	font-size: 20px;
	font-family: monospace;
        }
        
        window#waybar {
        	background: #292b2e;
        	color: #fdf6e3;
        }
        
        #custom-right-arrow-dark,
        #custom-left-arrow-dark {
        	color: #1a1a1a;
        }
        #custom-right-arrow-light,
        #custom-left-arrow-light {
        	color: #292b2e;
        	background: #1a1a1a;
        }
        
        #workspaces,
        #clock.1,
        #clock.2,
        #clock.3,
        #network,
        #pulseaudio,
        #memory,
        #cpu,
        #battery,
        #disk,
        #tray {
        	background: #1a1a1a;
        }
        
        #workspaces button {
        	padding: 0 2px;
        	color: #fdf6e3;
        }
        #workspaces button.focused {
        	color: #268bd2;
        }
        #workspaces button:hover {
        	box-shadow: inherit;
        	text-shadow: inherit;
        }
        #workspaces button:hover {
        	background: #1a1a1a;
        	border: #1a1a1a;
        	padding: 0 3px;
        }
        #network {
                color: #2980b9;
        }
        #network.disconnected {
                color: #f53c3c;
        }
        #pulseaudio {
        	color: #268bd2;
        }
        #memory {
        	color: #2aa198;
        }
        #cpu {
        	color: #6c71c4;
        }
        #battery {
        	color: #859900;
        }
        #disk {
        	color: #b58900;
        }
        
        #clock,
        #pulseaudio,
        #memory,
        #cpu,
        #battery,
        #disk {
        	padding: 0 10px;
        }
              '';
    };

}
