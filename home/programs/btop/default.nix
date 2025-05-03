{unstable, ...}: {
  programs.btop = {
    enable = true;
    package = unstable.btop;
    settings = {
      color_theme = "TTY";
      theme_background = false;
    };
  };
}
