{config, ...}: {
  programs.zathura = {
    enable = true;

    mappings = {
      r = "scroll down";
      f = "adjust_window best-fit";
    };

    options = {
      adjust-open = "best-fit";
      statusbar-basename = true;
      render-loading = false;
      scroll-step = 120;

      default-bg = "#" + config.var.theme.colors.bg;
      default-fg = "#" + config.var.theme.colors.fg;
      recolor = "true";
      recolor-lightcolor = "#" + config.var.theme.colors.bg;
      recolor-darkcolor = "#" + config.var.theme.colors.fg;

      # TexLab inverse search
      synctex = true;
      synctex-editor-command = "texlab inverse-search -i %{input} -l %{line}";
    };
  };
}
