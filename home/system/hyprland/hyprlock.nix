{config, ...}: {
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        disable_loading_bar = true;
        hide_cursor = true;
        ignore_empty_input = true;
        grace = 2;
        no_fade_in = false;
        no_fade_out = false;
      };

      background = {
        monitor = "";
        path = "$HOME/.wallpapers/${config.var.theme.wallpaper}";
        color = "rgb(${config.var.theme.colors.bg})";

        blur_size = 4;
        blur_passes = 3;
        noise = 1.17e-2;
        contrast = 1.3;
        brightness = 0.8;
        vibrancy = 0.21;
        vibrancy_darkness = 0.0;
      };

      input-field = [
        {
          monitor = "";
          size = "250, 50";
          outline_thickness = 0;
          dots_size = 0.2; # Scale of input-field height, 0.2 - 0.8
          dots_spacing = 0.64; # Scale of dots' absolute size, 0.0 - 1.0
          dots_center = true;
          inner_color = "rgba(0, 0, 0, 0.0)";
          check_color = "rgba(0, 0, 0, 0.0)";
          fail_color = "rgba(0, 0, 0, 0.0)";
          font_color = "rgb(${config.var.theme.colors.fg})";
          fade_on_empty = true;
          placeholder_text = "Password...";
          position = "0, 80";
          halign = "center";
          valign = "bottom";
        }
      ];

      label = [
        # Time
        {
          monitor = "";
          text = ''cmd[update:1000] echo "<b><big>$(date +"%H:%M:%S")</big></b>"'';
          color = "rgb(${config.var.theme.colors.fg})";
          font_family = config.var.theme.font-mono;
          font_size = 64;
          position = "0, 50";
          halign = "center";
          valign = "center";
        }
        # Date
        {
          monitor = "";
          text = ''
            cmd[update:60000] echo "<b><big>$(date +"%A %d %B %Y")</big></b>"
          '';
          color = "rgb(${config.var.theme.colors.fg})";
          font_size = config.var.theme.font-size + 2;
          font_family = config.var.theme.font;
          position = "0, 0";
          halign = "center";
          valign = "center";
        }
        # Type to unlock
        {
          monitor = "";
          text = "Type to unlock!";
          color = "rgb(${config.var.theme.colors.fg})";
          font_size = config.var.theme.font-size;
          font_family = config.var.theme.font;
          position = "0, 30";
          halign = "center";
          valign = "bottom";
        }
      ];
    };
  };
}
