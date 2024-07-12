{config, ...}: {
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      preload = ["~/.wallpapers/${config.var.theme.wallpaper}"];
      wallpaper = [",~/.wallpapers/${config.var.theme.wallpaper}"];
    };
  };
}
