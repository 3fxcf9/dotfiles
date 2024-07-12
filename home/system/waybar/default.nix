{
  config,
  lib,
  pkgs,
  ...
}: let
  caffeine-status = pkgs.writeShellScriptBin "caffeine-status" ''
    [[ -f /tmp/caffeine ]] && echo "1" || echo "0"
  '';

  caffeine = pkgs.writeShellScriptBin "caffeine" ''
    if [[ -f /tmp/caffeine ]]; then
      rm /tmp/caffeine
      ${pkgs.hyprland}/bin/hyprctl dispatch exec ${pkgs.hypridle}/bin/hypridle
      message="󰾪  Caffeine Deactivated"
    else
      touch /tmp/caffeine
      pkill hypridle
      message="󰅶  Caffeine Activated"
    fi
    notify-send "caffeine" "$message"
  '';

  caffeine-status-icon = pkgs.writeShellScriptBin "caffeine-status-icon" ''
    status=$(caffeine-status)
    if [[ $status == "1" ]]; then
      echo "󰅶"
    else
      echo "󰾪"
    fi
  '';
in {
  home.packages = [caffeine-status caffeine caffeine-status-icon];
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
        layer = config.var.theme.waybar.position;
        position = config.var.theme.waybar.position;
        height = 40;
        modules-left = ["hyprland/workspaces" "network" "clock" "hyprland/submap"];
        modules-right = [
          # "custom/sonnerie"
          "cpu"
          "memory"
          "temperature"
          "disk"
          "backlight"
          "pulseaudio"
          "custom/caffeine"
          "battery"
        ];
        "hyprland/workspaces" = {
          format = "{icon}";
          format-icons = {
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
        network = {
          format = "{icon}{essid}";
          format-alt = "{icon}{ipaddr}/{cidr}";
          format-alt-click = "click-left";
          format-icons = {
            wifi = ["<span foreground='#${config.var.theme.colors.accent}'> </span>"];
            ethernet = ["<span foreground='#${config.var.theme.colors.accent}'>󰈀 </span>"];
            disconnected = ["<span foreground='#${config.var.theme.colors.accent}'>󰖪 </span>"];
          };
          tooltip = false;
        };
        clock = {
          format = "<span color='#${config.var.theme.colors.accent}'> </span>{:%a %d %b %H:%M:%S}";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          interval = 1;
          calendar = {
            mode = "month";
            weeks-pos = "";
            on-scroll = 1;
            format = {
              months = "<span color='#f5f6ff'><b>{}</b></span>";
              days = "<span color='#f5f6ff'><b>{}</b></span>";
              weeks = "<span color='#${config.var.theme.colors.accent}'><b>W{}</b></span>";
              weekdays = "<span color='#${config.var.theme.colors.accent}'><b>{}</b></span>";
              today = "<span color='#ff6699'><b><u>{}</u></b></span>";
            };
          };
        };
        "hyprland/submap" = {
          format = "{}";
          tooltip = false;
        };
        # "custom/sonnerie" = {
        #   "format" = "<span color='#${config.var.theme.colors.accent}'>󰂜</span> {}";
        #   "exec" = "~/.config/waybar/scripts/sonnerie -c";
        #   "interval" = 1;
        # };
        cpu = {
          interval = 10;
          format = "<span color='#${config.var.theme.colors.accent}'> </span>{usage}%";
        };
        memory = {
          interval = 30;
          format = "<span color='#${config.var.theme.colors.accent}'> </span>{}%";
          max-length = 10;
        };
        temperature = {
          format = "<span foreground='#${config.var.theme.colors.accent}'>{icon} </span>{temperatureC}°C";
          format-icons = ["" "" "" "" ""];
        };
        disk = {
          interval = 30;
          format = "<span foreground='#${config.var.theme.colors.accent}'> </span>{percentage_used}%";
          path = "/";
        };
        backlight = {
          device = "intel_backlight";
          format = "<span color='#${config.var.theme.colors.accent}'>{icon}</span> {percent}%";
          format-icons = ["" "" "" "" "" "" "" "" ""];
          tooltip = false;
          scroll-step = 5;
          reverse-scrolling = true;
        };
        pulseaudio = {
          format = "<span color='#${config.var.theme.colors.accent}'>{icon}</span> {volume}%";
          format-muted = "󰸈";
          tooltip = false;
          format-icons = {
            headphone = "";
            default = ["󰕿" "󰖀" "󰕾" "󰕾"];
          };
          scroll-step = 5;
          on-click = "pavucontrol";
          on-click-right = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
          reverse-scrolling = true;
        };
        "custom/caffeine" = {
          format = "<span color='#${config.var.theme.colors.accent}'>{}</span>";
          exec = "caffeine-status-icon";
          exec-on-event = true;
          on-click = "caffeine";
          interval = 10;
          tooltip = false;
        };
        battery = {
          format = "<span color='#${config.var.theme.colors.accent}'>{icon}</span> {capacity}%";
          format-icons = ["󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
          format-charging = "<span color='#${config.var.theme.colors.accent}'>󰂄</span> {capacity}%";
          interval = 30;
          states = {
            warning = 25;
            critical = 10;
          };
          tooltip = false;
        };
      };
    };
    style = ''
      * {
        border: none;
        font-family: '${config.var.theme.font}', 'symbols nerd font mono';
        font-size: ${toString config.var.theme.waybar.font-size}pt;
        box-shadow: none;
        text-shadow: none;
        transition-duration: 0;
        font-feature-settings: '"zero", "ss01", "ss02", "ss03", "ss04", "ss05", "cv31"';
      }

      window#waybar {
        background-color: #${config.var.theme.colors.bg};
      }

      .module {
        margin: 0;
        padding: 0 10px;
        background-color: #${config.var.theme.colors.bg};
        color: #${config.var.theme.colors.fg};
      }

      /* FLOAT SPECIFIC */
      ${
        if config.var.theme.waybar.float
        then ''
          window#waybar {
            background: transparent;
          }
          #workspaces {
            margin-left: ${toString config.var.theme.gaps-out}px;
          }
          .module {
            margin-${toString config.var.theme.waybar.position}: ${toString config.var.theme.gaps-out}px;
          }
        ''
        else ""
      }
      /* END */

      #network, #clock, #workspaces, #custom-caffeine, #battery {
        border-radius: ${toString config.var.theme.rounding}px;
      }

      #workspaces {
        margin-right: ${toString config.var.theme.gaps-out}px;
      }

      #workspaces, #workspaces button {
        color: #${config.var.theme.colors.fgdark};
      }

      #workspaces button.active {
        background-color: #${config.var.theme.colors.bg};
        color: #${config.var.theme.colors.accent};
      }

      #workspaces button:hover {
        background: none;
        border: none;
      }

      #network {
        margin-right: ${toString config.var.theme.gaps-out}px;
      }

      #cpu {
        border-radius: ${toString config.var.theme.rounding}px 0 0 ${toString config.var.theme.rounding}px;
      }

      #disk {
        margin-right: ${toString config.var.theme.gaps-out}px;
        border-radius: 0 ${toString config.var.theme.rounding}px ${toString config.var.theme.rounding}px 0;
      }

      #backlight {
        border-radius: ${toString config.var.theme.rounding}px 0 0 ${toString config.var.theme.rounding}px;
      }

      #pulseaudio {
        margin-right: ${toString config.var.theme.gaps-out}px;
        border-radius: 0 ${toString config.var.theme.rounding}px ${toString config.var.theme.rounding}px 0;
      }

      #custom-caffeine {
        margin-right: ${toString config.var.theme.gaps-out}px;
      }

      #battery {
        margin-right: ${toString config.var.theme.gaps-out}px;
      }

      #battery.warning:not(.charging) {
        color: #${config.var.theme.colors.c1};
      }
    '';
  };
}
