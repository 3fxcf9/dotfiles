{
  pkgs,
  lib,
  config,
  ...
}: {
  programs.tofi = {
    enable = true;
    settings = {
      drun-launch = true;
      anchor = "bottom";
      width = "100%";
      height = "100%";
      # prompt-text = "run: ";
      outline-width = 0;
      border-width = 0;
      num-results = 5;
      padding-left = "35%";
      padding-top = "35%";
      result-spacing = "25";
      font = "MonaspiceXe Nerd Font Mono";
      background-color = "#000A";
      selection-color = "#b4befe";
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
