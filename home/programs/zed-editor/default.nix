{
  pkgs,
  lib,
  config,
  ...
}: {
  programs.zed-editor = {
    enable = true;
    extensions = ["nix"];

    userKeymaps = [
      # TODO: Zed keyboard shortcuts
      # {
      #   context = "ProjectPanel && not_editing";
      #   bindings = {
      #     "space e" = "project_panel::Open";
      #   };
      # }
    ];
    userSettings = {
      features = {
        copilot = false;
      };
      telemetry = {
        metrics = false;
      };
      assistant = {
        enabled = false;
      };

      hour_format = "hour24";
      auto_update = false;
      terminal = {
        alternate_scroll = "off";
        blinking = "off";
        copy_on_select = false;
        dock = "bottom";
        detect_venv = {
          on = {
            directories = [".env" "env" ".venv" "venv"];
            activate_script = "default";
          };
        };
        env = {
          TERM = "wezterm";
        };
        # font_features = null;
        # font_size = null;
        toolbar = {
          title = false;
        };
        working_directory = "current_project_directory";
      };

      lsp = {
        rust-analyzer = {
          binary = {
            path = lib.getExe pkgs.rust-analyzer;
          };
        };
      };

      tabs = {
        file_icons = true;
        git_status = true;
      };

      theme = "Tokyo Night";
      "experimental.theme_overrides" = {
        syntax = {
          comment = {
            font_style = "italic";
          };
          "comment.doc" = {
            font_style = "italic";
          };
          "comment.documentation" = {
            font_style = "italic";
          };
          "comment.error" = {
            font_style = "italic";
          };
          "comment.warning" = {
            font_style = "italic";
          };
          "comment.hint" = {
            font_style = "italic";
          };
          "comment.todo" = {
            font_style = "italic";
          };
          "comment.note" = {
            font_style = "italic";
          };
          namespace = {
            font_style = "italic";
          };
          "tag.attribute" = {
            font_style = "italic";
          };
          emphasis = {
            font_style = "italic";
          };
          "string.special.url" = {
            font_style = "italic";
          };
          "type.builtin" = {
            font_style = "italic";
          };
          "type.interface" = {
            font_style = "italic";
          };
          "type.super" = {
            font_style = "italic";
          };
          "module" = {
            font_style = "italic";
          };
          "variable.special" = {
            font_style = "italic";
          };
        };
        "background" = "#" + config.var.theme.colors.bg;
        "element.background" = "#" + config.var.theme.colors.bg;
        "ghost_element.background" = "#" + config.var.theme.colors.bg;
        "status_bar.background" = "#" + config.var.theme.colors.bg;
        "title_bar.background" = "#" + config.var.theme.colors.bg;
        "title_bar.inactive_background" = "#" + config.var.theme.colors.bg;
        "toolbar.background" = "#" + config.var.theme.colors.bg;
        "tab_bar.background" = "#" + config.var.theme.colors.bg;
        "tab.inactive_background" = "#" + config.var.theme.colors.bg;
        "tab.active_background" = "#" + config.var.theme.colors.bg;
        "terminal.background" = "#" + config.var.theme.colors.bg;
        "panel.background" = "#" + config.var.theme.colors.bg;
        "editor.background" = "#" + config.var.theme.colors.bg;
        "editor.gutter.background" = "#" + config.var.theme.colors.bg;
        "editor.subheader.background" = "#" + config.var.theme.colors.bg;
        "elevated_surface.background" = "#" + config.var.theme.colors.bg;
        "surface.background" = "#" + config.var.theme.colors.bg;
        "drop_target.background" = "#" + config.var.theme.colors.bg;
        "editor.indent_guide" = "#" + config.var.theme.colors.c4;
        "editor.indent_guide_active" = "#" + config.var.theme.colors.c12;
      };

      vim_mode = true;
      relative_line_numbers = true;
      vertical_scroll_margin = 20;
      ui_font_size = 16;
      buffer_font_size = 16;
    };
  };
}
