{ config, ... }: {
  programs.alacritty = {
    enable = true;
    settings = {
      keyboard.bindings = [{
        key = "I";
        mods = "Control|Shift";
        action = "ToggleViMode";
      }];
      colors = {
        primary = {
          background = "#" + config.var.theme.colors.bg;
          foreground = "#" + config.var.theme.colors.fg;
        };
        footer_bar = {
          foreground = "#" + config.var.theme.colors.c3;
          background = "#" + config.var.theme.colors.bg;
        };
        line_indicator = {
          foreground = "#" + config.var.theme.colors.c3;
          background = "#" + config.var.theme.colors.bg;
        };
        normal = {
          black = "#" + config.var.theme.colors.c0;
          red = "#" + config.var.theme.colors.c1;
          green = "#" + config.var.theme.colors.c2;
          yellow = "#" + config.var.theme.colors.c3;
          blue = "#" + config.var.theme.colors.c4;
          magenta = "#" + config.var.theme.colors.c5;
          cyan = "#" + config.var.theme.colors.c6;
          white = "#" + config.var.theme.colors.c7;
        };
        # Bright colors;
        bright = {
          black = "#" + config.var.theme.colors.c8;
          red = "#" + config.var.theme.colors.c9;
          green = "#" + config.var.theme.colors.c10;
          yellow = "#" + config.var.theme.colors.c11;
          blue = "#" + config.var.theme.colors.c12;
          magenta = "#" + config.var.theme.colors.c13;
          cyan = "#" + config.var.theme.colors.c14;
          white = "#" + config.var.theme.colors.c15;
        };
      };
      font = {
        size = 10;
        normal.family = config.var.theme.font-mono;
        italic.family = config.var.theme.font-mono;
        bold.family = config.var.theme.font-mono;
      };
      window = {
        opacity = 1;
        padding = {
          x = config.var.theme.gaps-out * 2;
          y = config.var.theme.gaps-out;
        };
      };
      hints.alphabet = "rtiunesalfmpdoh-gx";
    };
  };
}
