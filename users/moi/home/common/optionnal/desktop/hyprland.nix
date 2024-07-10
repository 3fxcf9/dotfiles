{
  config,
  inputs,
  pkgs,
  osConfig,
  ...
}: let
  isBeta = osConfig.networking.hostName == "beta";
  screenOffset =
    if isBeta
    then "910"
    else "700";
in {
  home.packages = with pkgs; [
    wl-clipboard
    tofi
    wayland-protocols
    wayland-utils
    wlroots
    nwg-displays
    hyprshot
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    settings.debug = {
      disable_logs = false;
    };
    extraConfig = ''
      exec-once = dunst
      exec-once = hyprpaper
      exec = pkill waybar; sleep 1; waybar

      # Some default env vars.
      env = XCURSOR_SIZE,20

      # Monitors
      monitor=,preferred,auto,1

      input {
        kb_layout = ergol

        numlock_by_default = yes
        kb_options = ctrl:nocaps,altwin:swap_lalt_lwin

        follow_mouse = 1

        touchpad {
          natural_scroll = yes
        }
        scroll_method = 2fg

        sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
      }

      general {
        gaps_in = 4
        gaps_out = 8
        border_size = 1

        col.active_border = rgba(b4befeff)
        col.inactive_border = rgba(000000ff)

        layout = dwindle
      }

      dwindle {
        force_split = 2
        smart_split = yes
      }

      decoration {
        rounding = 4 # 5-1 for the borders
        drop_shadow = no

        blur {
          enabled = false
          #size = 3
          #passes = 1
          #new_optimizations = true
        }

        #windowrulev2 = opacity 0.9 0.9,class:^(Code|Alacritty|org.gnome.Nautilus|Signal)$
      }

      animations {
        enabled = no
        first_launch_animation = no
      }

      misc {
        mouse_move_enables_dpms = false
        key_press_enables_dpms = true
        force_default_wallpaper = 0
        disable_splash_rendering = true
        disable_hyprland_logo = true
      }

      $MOD = SUPER

      bind = $MOD, SPACE, exec, tofi-drun
      bind = $MOD, RETURN, exec, alacritty
      bind = $MOD SHIFT, A, killactive,

      bind = $MOD, F,fullscreen, 1 # Maximizing
      bind = $MOD SHIFT, F,fullscreen, 0 # Fullscreen

      bind = $MOD, M, exit,
      bind = $MOD, V, togglefloating,
      bind = $MOD, U, togglesplit,
      bind = $MOD SHIFT, S, exec, hyprshot -m region --clipboard-only # Screenshot

      # Multimonitor
      bind = $MOD, B, exec, hyprctl dispatch movecurrentworkspacetomonitor -1
      bind = $MOD, F11, exec, hyprctl keyword monitor eDP-1,preferred,0x${screenOffset},1.0,transform,2
      bind = $MOD SHIFT, F11, exec, hyprctl keyword monitor eDP-1,preferred@60,0x${screenOffset}

      # Move focus with MOD + arrow keys
      bind = $MOD, left, movefocus, l
      bind = $MOD, right, movefocus, r
      bind = $MOD, up, movefocus, u
      bind = $MOD, down, movefocus, d

      bind = $MOD, H, movefocus, l
      bind = $MOD, L, movefocus, r
      bind = $MOD, K, movefocus, u
      bind = $MOD, R, movefocus, d

      bind = $MOD SHIFT, L, movewindow, l
      bind = $MOD SHIFT, K, movewindow, r
      bind = $MOD SHIFT, H, movewindow, u
      bind = $MOD SHIFT, R, movewindow, d

      # Switch workspaces
      bind = $MOD, 1, workspace, 1
      bind = $MOD, 2, workspace, 2
      bind = $MOD, 3, workspace, 3
      bind = $MOD, 4, workspace, 4
      bind = $MOD, 5, workspace, 5
      bind = $MOD, 6, workspace, 6
      bind = $MOD, 7, workspace, 7
      bind = $MOD, 8, workspace, 8
      bind = $MOD, 9, workspace, 9
      bind = $MOD, 0, workspace, 10

      # Move active window to a workspace
      bind = $MOD SHIFT, 1, movetoworkspace, 1
      bind = $MOD SHIFT, 2, movetoworkspace, 2
      bind = $MOD SHIFT, 3, movetoworkspace, 3
      bind = $MOD SHIFT, 4, movetoworkspace, 4
      bind = $MOD SHIFT, 5, movetoworkspace, 5
      bind = $MOD SHIFT, 6, movetoworkspace, 6
      bind = $MOD SHIFT, 7, movetoworkspace, 7
      bind = $MOD SHIFT, 8, movetoworkspace, 8
      bind = $MOD SHIFT, 9, movetoworkspace, 9
      bind = $MOD SHIFT, 0, movetoworkspace, 10

      # Move/resize windows with MOD + LMB/RMB and dragging
      bindm = $MOD, mouse:272, movewindow
      bindm = $MOD, mouse:273, resizewindow
    '';
  };
}
