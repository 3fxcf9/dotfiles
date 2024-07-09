{pkgs, ...}: {
  imports = [
    ./hyprland.nix
    ./waybar.nix
    ./gtk.nix
    ./tofi.nix
    ./dunst.nix
    ./hyprpaper.nix
  ];

  # Hyprland wallpaper
  xdg.configFile."hypr/wallpaper.jpg".source = ./wallpaper.jpg;
}
