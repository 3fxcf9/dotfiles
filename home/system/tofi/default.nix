{
  lib,
  config,
  ...
}: {
  # TODO: Clean fixed px sizes
  programs.tofi = {
    enable = true;
    settings = {
      drun-launch = true;
      hide-cursor = true;
      width = 500;
      height = 290;
      clip-to-padding = false;
      outline-width = 0;
      border-width = 2;
      border-color = config.var.theme.colors.accent;
      background-color = config.var.theme.colors.bg;
      corner-radius = config.var.theme.rounding;
      padding-left = 35;
      padding-top = 25;
      padding-bottom = 25;
      padding-right = 25;
      num-results = 5;
      result-spacing = 15;
      font = "MonaspiceNe Nerd Font Mono";
      font-size = 16;
      placeholder-text = "Execute...";
      prompt-text = "> ";
      prompt-background = config.var.theme.colors.accent;
      prompt-color = config.var.theme.colors.accentFg;
      prompt-background-corner-radius = 2;
      prompt-background-padding = "5,20,3";
      prompt-padding = 35;
      selection-color = config.var.theme.colors.c3;
      physical-keybindings = false;
      ascii-input = false;
      hint-font = false;
    };
  };

  # Update tofi cache
  home.activation = {
    # https://github.com/philj56/tofi/issues/115#issuecomment-1701748297
    regenerateTofiCache = lib.hm.dag.entryAfter ["writeBoundary"] ''
      tofi_cache=${config.xdg.cacheHome}/tofi-drun
      [[ -f "$tofi_cache" ]] && rm "$tofi_cache"
    '';
  };
}
