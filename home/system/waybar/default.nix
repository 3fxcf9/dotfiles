{
  config,
  pkgs,
  ...
}: let
  anki-edit-launcher = pkgs.writeShellScriptBin "anki-edit-launcher" ''
    curl localhost:8765 -X POST -s -d "{\"action\": \"guiAddCards\", \"params\": {\"note\": {\"deckName\": \"$(curl localhost:8765 -X POST -s -d '{"action": "deckNames", "version": 6}' | jq  -r '.result[]' | tofi)\", \"modelName\":\"Basic\"}}, \"version\": 6}"
  '';
  tofi-network-menu = pkgs.writeShellScriptBin "tofi-network-menu" ''
    # Function to escape special characters for grep
    escape_for_grep() {
        sed 's/[.*+?^''${}()|[\]\\]/\\&/g' <<< "$1"
    }

    wifi_status=$(nmcli radio wifi)

    if [ "$wifi_status" = "disabled" ]; then
        networks="ENABLE WIFI"
    else
        networks=$(nmcli -f SSID,SECURITY,SIGNAL device wifi list | tail -n +2 | sed 's/^ *//g' | sort -k3 -nr)
        networks="DISCONNECT\nDISABLE WIFI\n$networks"
    fi

    selected=$(echo -e "$networks" | tofi --width 800 --height 350 --num-results 8 --prompt-text " " --placeholder-text "Network name or action...")
    ssid=$(echo "$selected" | awk -F' {2,}' '{print $1}')

    if [ -z "$ssid" ]; then
        exit 1
    fi

    if [ "$ssid" = "ENABLE WIFI" ]; then
        nmcli radio wifi on
        exit 0
    elif [ "$ssid" = "DISCONNECT" ]; then
        nmcli device disconnect wlp1s0
        exit 0
    elif [ "$ssid" = "DISABLE WIFI" ]; then
        nmcli radio wifi off
        exit 0
    fi

    if nmcli -t -f NAME connection show | grep -q "^$(escape_for_grep "$ssid")$"; then
        nmcli connection up id "$ssid"
    else
        if echo "$selected" | grep -q "[^ ]* {2,}.*"; then
            password=$(tofi --prompt-text " " --placeholder-text "Password for $ssid:")
            if [ -z "$password" ]; then
                exit 1
            fi
            nmcli device wifi connect "$ssid" password "$password"
        else
            nmcli device wifi connect "$ssid"
        fi
    fi
  '';
in {
  home.packages = [pkgs.curl pkgs.jq pkgs.tofi anki-edit-launcher tofi-network-menu];

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
        modules-left = ["hyprland/workspaces" "network" "clock" "hyprland/submap" "custom/anki"];
        modules-right = [
          # "custom/sonnerie"
          "cpu"
          "memory"
          "temperature"
          "disk"
          "backlight"
          "pulseaudio"
          "idle_inhibitor"
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
          format = "<span foreground='#${config.var.theme.colors.accent}'>{icon}</span> {essid}";
          format-alt = "<span foreground='#${config.var.theme.colors.accent}'>{icon}</span> {ipaddr}/{cidr}";
          format-alt-click = "click-left";
          format-icons = {
            wifi = [" "];
            ethernet = ["󰈀 "];
            disconnected = ["󰖪 "];
          };
          on-click-right = "tofi-network-menu";
          tooltip = false;
        };
        clock = {
          format = "<span color='#${config.var.theme.colors.accent}'> </span> {:%a %d %b %H:%M:%S}";
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
        "custom/anki" = {
          format = "<span color='#${config.var.theme.colors.accent}'>󰠮</span>";
          on-click = "anki-edit-launcher";
          tooltip = false;
        };
        # "custom/sonnerie" = {
        #   "format" = "<span color='#${config.var.theme.colors.accent}'>󰂜</span> {}";
        #   "exec" = "~/.config/waybar/scripts/sonnerie -c";
        #   "interval" = 1;
        # };
        cpu = {
          interval = 10;
          format = "<span color='#${config.var.theme.colors.accent}'> </span> {usage}%";
        };
        memory = {
          interval = 30;
          format = "<span color='#${config.var.theme.colors.accent}'> </span> {}%";
          max-length = 10;
        };
        temperature = {
          format = "<span foreground='#${config.var.theme.colors.accent}'>{icon} </span>{temperatureC}°C";
          format-icons = ["" "" "" "" ""];
        };
        disk = {
          interval = 30;
          format = "<span foreground='#${config.var.theme.colors.accent}'> </span> {percentage_used}%";
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
        idle_inhibitor = {
          format = "<span color='#${config.var.theme.colors.accent}'>{icon}</span>";
          format-icons = {
            activated = "󰅶";
            deactivated = "󰾪";
          };
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
        font-family: '${config.var.theme.font-mono}', 'symbols nerd font mono';
        font-size: ${toString config.var.theme.waybar.font-size}pt;
        box-shadow: none;
        text-shadow: none;
        background: none;
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

      #network, #clock, #workspaces, #idle_inhibitor, #battery, #custom-anki {
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

      #network, #clock {
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

      #idle_inhibitor {
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
