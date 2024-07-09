{pkgs, ...}: {
  services.dunst = {
    enable = true;
    settings = {
      global = {
        frame_color = "#b4befe";
        separator_color = "frame";
        title = "Dunst";
        class = "Dunst";
        monitor = 0;
        follow = "mouse";
        width = 300;
        height = 300;
        origin = "top-right";
        offset = "8x8";
        indicate_hidden = true;
        shrink = true;

        transparency = 5;
        separator_height = 3;
        padding = 8;
        horizontal_padding = 11;
        frame_width = 1;

        font = "Cantarell 9";

        line_height = 0;
        markup = "full";
        format = "<span size='x-large' weight='bold' foreground='#f5f6ff'>%s</span>\n%b";
        alignment = "left";

        idle_threshold = 120;
        show_age_threshold = 60;
        sort = false;
        word_wrap = true;
        ignore_newline = false;
        stack_duplicates = false;
        hide_duplicate_count = true;
        show_indicators = false;
        sticky_history = false;
        history_length = 20;
        always_run_script = true;
        corner_radius = 5;
        icon_position = "left";
        max_icon_size = 80;

        mouse_left_click = "close_current";
        mouse_middle_click = "close_all";
        mouse_right_click = "close_all";

        browser = "librewolf";
      };

      urgency_low = {
        background = "#000000";
        foreground = "#f5f6ff";
      };

      urgency_normal = {
        background = "#000000";
        foreground = "#f5f6ff";
      };
      urgency_critical = {
        background = "#000000";
        foreground = "#f5f6ff";
        frame_color = "#c94c4c";
      };
    };
  };
}
