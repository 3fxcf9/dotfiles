{pkgs, ...}: {
  services.hyprpaper = {
    enable = true;
    settings = {
      splash = false;
      preload = "~/.config/hypr/wallpaper.jpg";
      wallpaper = ",~/.config/hypr/wallpaper.jpg";
    };
  };
}
