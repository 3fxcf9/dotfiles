{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.waybar = {
    enable = true;
    package = pkgs.waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ ["-Dexperimental=true"];
    });
    systemd = {
      enable = false;
      target = "graphical-session.target";
    };
    settings = {
      mainBar = {
        layer = "bottom";
        position = "top";
        height = 30;
        modules-left = ["hyprland/workspaces" "network" "clock" "hyprland/submap"];
        modules-right = [
          # "custom/sonnerie"
          "custom/updates"
          "cpu"
          "memory"
          "temperature"
          "disk"
          "backlight"
          "pulseaudio"
          "battery"
        ];
        "hyprland/workspaces" = {
          "format" = "{icon}";
          "format-icons" = {
            "1" = "一";
            "2" = "二";
            "3" = "三";
            "4" = "四";
            "5" = "五";
            "6" = "六";
            "7" = "七";
            "8" = "八";
            "9" = "九";
            "10" = "十";
          };
        };
        "network" = {
          "format" = "{icon}{essid}";
          "format-alt" = "{icon}{ipaddr}/{cidr}";
          "format-alt-click" = "click-left";
          "format-icons" = {
            "wifi" = ["<span foreground='#b4befe'> </span>"];
            "ethernet" = ["<span foreground='#b4befe'>󰈀 </span>"];
            "disconnected" = ["<span foreground='#b4befe'>󰖪 </span>"];
          };
          "tooltip" = false;
        };
        "clock" = {
          "format" = "<span color='#b4befe'> </span>{:%a %d %b %H:%M:%S}";
          "tooltip-format" = "<tt><small>{calendar}</small></tt>";
          "interval" = 1;
          "calendar" = {
            "mode" = "month";
            #"mode-mon-col" = 3;
            "weeks-pos" = "";
            "on-scroll" = 1;
            "format" = {
              "months" = "<span color='#f5f6ff'><b>{}</b></span>";
              "days" = "<span color='#f5f6ff'><b>{}</b></span>";
              "weeks" = "<span color='#b4befe'><b>W{}</b></span>";
              "weekdays" = "<span color='#b4befe'><b>{}</b></span>";
              "today" = "<span color='#ff6699'><b><u>{}</u></b></span>";
            };
          };
        };
        "hyprland/submap" = {
          "format" = "{}";
          "tooltip" = false;
        };
        # "custom/sonnerie" = {
        #   "format" = "<span color='#b4befe'>󰂜</span> {}";
        #   "exec" = "~/.config/waybar/scripts/sonnerie -c";
        #   "interval" = 1;
        # };
        "cpu" = {
          "interval" = 10;
          "format" = "<span color='#b4befe'> </span>{usage}%";
        };
        "memory" = {
          "interval" = 30;
          "format" = "<span color='#b4befe'> </span>{}%";
          "max-length" = 10;
        };
        "temperature" = {
          "format" = "<span foreground='#b4befe'>{icon} </span>{temperatureC}°C";
          "format-icons" = ["" "" "" "" ""];
        };
        "disk" = {
          "interval" = 30;
          "format" = "<span foreground='#b4befe'> </span>{percentage_used}%";
          "path" = "/";
        };
        "backlight" = {
          "device" = "intel_backlight";
          "format" = "<span color='#b4befe'>{icon}</span> {percent}%";
          "format-icons" = ["" "" "" "" "" "" "" "" ""];
          "tooltip" = false;
          "scroll-step" = 5;
        };
        "pulseaudio" = {
          "format" = "<span color='#b4befe'>{icon}</span> {volume}%";
          "format-muted" = "󰸈";
          "tooltip" = false;
          "format-icons" = {
            "headphone" = "";
            "default" = ["󰕿" "󰖀" "󰕾" "󰕾"];
          };
          "scroll-step" = 5;
          "on-click" = "pavucontrol";
          "on-click-right" = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
        };
        "battery" = {
          "format" = "<span color='#b4befe'>{icon}</span> {capacity}%";
          "format-icons" = ["󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
          "format-charging" = "<span color='#b4befe'>󰂄</span> {capacity}%";
          "interval" = 30;
          "states" = {
            "warning" = 25;
            "critical" = 10;
          };
          "tooltip" = false;
        };
      };
    };
    style = ''
      * {
        border: none;
        font-family: 'monaspace neon', 'symbols nerd font mono';
        font-size: 13px;
        box-shadow: none;
        text-shadow: none;
        transition-duration: 0;
        font-feature-settings: '"zero", "ss01", "ss02", "ss03", "ss04", "ss05", "cv31"';
      }

      window#waybar {
        background: transparent;
      }

      .module {
        padding: 0 10px;
        margin-top: 8px;
        color: #f5f6ff;
        background-color: #050518;
      }

      #workspaces {
        margin-left: 8px;
        margin-right: 8px;
        border-radius: 5px;
      }

      #network {
        margin-right: 8px;
      }

      #workspaces button {
        color: #333343;
      }

      #workspaces button.active {
        background-color: #050518;
        color: #b4befe;
      }

      #workspaces button:hover {
        background-color: #050518;
      }

      #network, #clock {
        border-radius: 5px;
      }

      #custom-sonnerie {
        border-radius: 5px;
        margin-right: 8px;
      }

      #cpu {
        border-radius: 5px 0 0 5px;
      }

      #disk {
        margin-right: 8px;
        border-radius: 0 5px 5px 0;
      }

      #backlight {
        border-radius: 5px 0 0 5px;
      }

      #pulseaudio {
        margin-right: 8px;
        border-radius: 0 5px 5px 0;
      }

      #battery {
        margin-right: 8px;
        border-radius: 5px;
      }

      #battery.warning:not(.charging) {
        color: red;
      }
    '';
  };
}
