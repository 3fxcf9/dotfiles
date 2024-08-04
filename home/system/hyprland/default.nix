{
  config,
  inputs,
  pkgs,
  osConfig,
  ...
}: let
  startup = pkgs.writeShellScriptBin "startup" ''
    # Called by Hyprland on startup

    pkill waybar; sleep 1; ${pkgs.waybar}/bin/waybar &
    ${pkgs.hyprpaper}/bin/hyprpaper &
    ${pkgs.hypridle}/bin/hypridle &
  '';
  isBeta = osConfig.networking.hostName == "beta";
  screenOffset =
    if isBeta
    then "910"
    else "700";
in {
  imports = [
    ./hypridle.nix
    ./hyprlock.nix
    ./hyprpaper.nix
  ];

  home.packages = [
    startup

    pkgs.wl-clipboard
    pkgs.tofi
    pkgs.wayland-protocols
    pkgs.wayland-utils
    pkgs.wlroots
    pkgs.nwg-displays
    pkgs.hyprshot
    pkgs.hyprpicker
    pkgs.hypridle
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    settings = {
      "$MOD" = "SUPER";

      exec-once = ["startup"];

      monitor = [
        ",preferred,auto,1"
      ];

      env = [
        "XDG_SESSION_TYPE,wayland"
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
        "XDG_SESSION_DESKTOP,Hyprland"
        "QT_AUTO_SCREEN_SCALE_FACTOR,1"
        "QT_QPA_PLATFORM=wayland,xcb"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
        "ELECTRON_OZONE_PLATFORM_HINT,auto"
        "HYPRCURSOR_SIZE,20"
        "XCURSOR_SIZE,20"
      ];

      general = {
        gaps_in = config.var.theme.gaps-in;
        gaps_out = config.var.theme.gaps-out;
        border_size = config.var.theme.border-size;
        "col.active_border" = "rgba(${config.var.theme.colors.accent}ff)";
        "col.inactive_border" = "rgba(${config.var.theme.colors.bg}ff)";
        layout = "master";
      };
      master.new_status = "master";

      decoration = {
        rounding = config.var.theme.rounding - config.var.theme.border-size;
        blur = {enabled = false;};
        drop_shadow = false;
      };

      gestures = {
        workspace_swipe = true;
        workspace_swipe_distance = 50;
      };
      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        focus_on_activate = true;
        new_window_takes_over_fullscreen = 2; # Unfullscreen current fullscreen window
        mouse_move_enables_dpms = false;
        key_press_enables_dpms = true;
        force_default_wallpaper = 0;
      };
      input = {
        # FIXME: Ergol as layout ?
        # kb_layout = config.var.keyboardLayout;
        kb_layout = "ergol";
        kb_options = "altwin:swap_lalt_lwin"; # Caps lock is ctrl and SUPER/ALT are swapped
        # kb_options = "ctrl:nocaps,altwin:swap_lalt_lwin"; # Caps lock is ctrl and SUPER/ALT are swapped
        follow_mouse = 1;
        scroll_method = "2fg";
        sensitivity = 0; # -1.0 - 1.0, 0 means no modification.
        repeat_delay = 200;
        repeat_rate = 50;
        numlock_by_default = true;
        touchpad.natural_scroll = true;
      };
      animations = {
        enabled = false;
        first_launch_animation = false;
      };

      bind = [
        "$MOD, SPACE, exec, tofi-drun"
        "$MOD, RETURN, exec, alacritty"
        "$MOD SHIFT, A, killactive,"

        "$MOD, F,fullscreen, 1 # Maximizing"
        "$MOD SHIFT, F,fullscreen, 0 # Fullscreen"

        "$MOD, M, exit,"
        "$MOD, V, togglefloating,"
        "$MOD, S, exec, hyprshot -m region --clipboard-only # Screenshot"
        "$MOD, C, exec, hyprpicker -a # Color picker"
        "$MOD, F12, exec, hyprlock # Lock screen"

        # Multimonitor
        "$MOD, B, exec, hyprctl dispatch movecurrentworkspacetomonitor -1"
        "$MOD, F11, exec, hyprctl keyword monitor eDP-1,preferred,0x${screenOffset},1.0,transform,2"
        "$MOD SHIFT, F11, exec, hyprctl keyword monitor eDP-1,preferred@60,0x${screenOffset}"

        # Move focus with MOD + arrow keys
        "$MOD, left, movefocus, l"
        "$MOD, right, movefocus, r"
        "$MOD, up, movefocus, u"
        "$MOD, down, movefocus, d"

        "$MOD, H, movefocus, l"
        "$MOD, L, movefocus, r"
        "$MOD, K, movefocus, u"
        "$MOD, R, movefocus, d"

        "$MOD SHIFT, L, movewindow, l"
        "$MOD SHIFT, K, movewindow, r"
        "$MOD SHIFT, H, movewindow, u"
        "$MOD SHIFT, R, movewindow, d"

        # Switch workspaces
        "$MOD, 1, workspace, 1"
        "$MOD, 2, workspace, 2"
        "$MOD, 3, workspace, 3"
        "$MOD, 4, workspace, 4"
        "$MOD, 5, workspace, 5"
        "$MOD, 6, workspace, 6"
        "$MOD, 7, workspace, 7"
        "$MOD, 8, workspace, 8"
        "$MOD, 9, workspace, 9"
        "$MOD, 0, workspace, 10"

        # Move active window to a workspace
        "$MOD SHIFT, 1, movetoworkspace, 1"
        "$MOD SHIFT, 2, movetoworkspace, 2"
        "$MOD SHIFT, 3, movetoworkspace, 3"
        "$MOD SHIFT, 4, movetoworkspace, 4"
        "$MOD SHIFT, 5, movetoworkspace, 5"
        "$MOD SHIFT, 6, movetoworkspace, 6"
        "$MOD SHIFT, 7, movetoworkspace, 7"
        "$MOD SHIFT, 8, movetoworkspace, 8"
        "$MOD SHIFT, 9, movetoworkspace, 9"
        "$MOD SHIFT, 0, movetoworkspace, 10"
      ];

      bindm = [
        # Move/resize windows with MOD + LMB/RMB and dragging
        "$MOD, mouse:272, movewindow"
        "$MOD, mouse:273, resizewindow"
      ];
    };
  };
}
