{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [libnotify];

  services.dunst = {
    enable = true;
    iconTheme = {
      name = "adwaita";
      package = pkgs.adwaita-icon-theme;
    };
    settings = {
      global = {
        rounded = "yes";
        origin = "top-right";
        monitor = 0;
        alignment = "left";
        vertical_alignment = "center";

        width = 400;
        height = 400;
        scale = 0;
        gap_size = 0;
        transparency = 0;
        text_icon_padding = 0;
        separator_color = "frame";
        sort = true;
        idle_threshold = 120;
        line_height = 0;
        markup = "full";
        show_age_threshold = 60;
        ellipsize = "middle";
        ignore_newline = false;
        stack_duplicates = true;
        sticky_history = true;
        history_length = 20;
        always_run_script = true;
        corner_radius = config.var.theme.rounding;
        follow = "mouse";
        font = config.var.theme.font;
        format = "<b>%s</b>\\n%b";
        progress_bar = true;
        progress_bar_corner_radius = config.var.theme.rounding - 10;
        frame_color = "#" + config.var.theme.colors.accent;
        highlight = "#" + config.var.theme.colors.accent;
        foreground = "#" + config.var.theme.colors.fg;
        frame_width = config.var.theme.border-size;
        offset = toString config.var.theme.gaps-out + "x" + toString config.var.theme.gaps-out;
        horizontal_padding = 10;
        icon_position = "left";
        indicate_hidden = true;
        min_icon_size = 0;
        max_icon_size = 64;
        mouse_left_click = "do_action, close_current";
        mouse_middle_click = "close_current";
        mouse_right_click = "close_all";
        padding = 10;
        plain_text = false;
        separator_height = 2;
        show_indicators = true;
        shrink = false;
        word_wrap = true;
        browser = "${pkgs.firefox}/bin/firefox";
      };

      fullscreen_delay_everything = {fullscreen = "delay";};

      urgency_critical = {
        frame_color = "#" + config.var.theme.colors.c1;
        foreground = "#" + config.var.theme.colors.fg;
        background = "#" + config.var.theme.colors.bg;
      };
      urgency_low = {
        frame_color = "#" + config.var.theme.colors.fgdark;
        foreground = "#" + config.var.theme.colors.fg;
        background = "#" + config.var.theme.colors.bg;
      };
      urgency_normal = {
        foreground = "#" + config.var.theme.colors.fg;
        background = "#" + config.var.theme.colors.bg;
      };
    };
  };
}
