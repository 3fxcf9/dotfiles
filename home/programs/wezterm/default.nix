{
  inputs,
  pkgs,
  lib,
  config,
  ...
}: {
  programs.wezterm = {
    enable = true;
    package = inputs.wezterm.packages.${pkgs.system}.default;
    extraConfig = lib.mkForce ''
      local wezterm = require("wezterm")

      local config = wezterm.config_builder()

      config.color_scheme = "Tokyo Night"
      config.colors = {
      	background = "#${config.var.theme.colors.bg}",
      	foreground = "#${config.var.theme.colors.fg}",
        ansi = {
            '#${config.var.theme.colors.c0}',
            '#${config.var.theme.colors.c1}',
            '#${config.var.theme.colors.c2}',
            '#${config.var.theme.colors.c3}',
            '#${config.var.theme.colors.c4}',
            '#${config.var.theme.colors.c5}',
            '#${config.var.theme.colors.c6}',
            '#${config.var.theme.colors.c7}',
          },
          brights = {
            '#${config.var.theme.colors.c8}',
            '#${config.var.theme.colors.c9}',
            '#${config.var.theme.colors.c10}',
            '#${config.var.theme.colors.c11}',
            '#${config.var.theme.colors.c12}',
            '#${config.var.theme.colors.c13}',
            '#${config.var.theme.colors.c14}',
            '#${config.var.theme.colors.c15}',
          },
      }

      config.window_padding = {
      	left = ${toString (config.var.theme.gaps-out * 2)},
      	right = ${toString (config.var.theme.gaps-out * 2)},
      	top = ${toString config.var.theme.gaps-out},
      	bottom = ${toString config.var.theme.gaps-out},
      }

      config.font = wezterm.font_with_fallback({
        "${config.var.theme.font-mono}",
        "${config.var.theme.font-mono-italic}",
      })

      config.font_rules = {
        {
          italic = true,
          font = wezterm.font {
            family = "${config.var.theme.font-mono-italic}",
            style = "Italic",
          },
        },
      }

      --config.font = wezterm.font("${config.var.theme.font-mono}")
      config.harfbuzz_features = {
      	"calt=1",
      	"clig=1",
      	"liga=1",
      	"ss01=1",
      	"ss02=1",
      	"ss03=1",
      	"ss04=1",
      	"ss05=1",
      	"ss06=1",
      	"ss07=1",
      	"ss08=1",
      	"ss09=1",
      	"ss10=1",
      	"ss11=1",
      	"ss12=1",
      	"ss13=1",
      	"ss14=1",
      	"ss15=1",
      	"ss16=1",
      	"ss17=1",
      	"ss18=1",
      	"ss19=1",
      	"ss20=1",
      }
      config.font_size = 12

      config.enable_tab_bar = false
      config.window_decorations = "NONE"

      config.use_ime = false

      config.keys = {
        { key = "h", mods = "ALT", action = wezterm.action.SendKey { key = "LeftArrow" } },
        { key = "j", mods = "ALT", action = wezterm.action.SendKey { key = "DownArrow" } },
        { key = "k", mods = "ALT", action = wezterm.action.SendKey { key = "UpArrow" } },
        { key = "l", mods = "ALT", action = wezterm.action.SendKey { key = "RightArrow" } },
      }

      return config
    '';
    # config.use_dead_keys = true
    # config.enable_kitty_keyboard = true
    # config.enable_csi_u_key_encoding = true
    # config.keys = {
    #   {
    #     key = 'o',
    #     mods = 'NONE',
    #     action = wezterm.action.DisableDefaultAssignment,
    #   },
    # },
  };
}
