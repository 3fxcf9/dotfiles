{pkgs, ...}: {
  imports = [
    ./hyprland.nix
    ./waybar.nix
    ./gtk.nix
  ];
  home.packages = with pkgs; [tofi hyprpaper];

  # Tofi app launcher
  xdg.configFile."tofi/config".source = ./tofi_config;

  # Dunst
  xdg.configFile."dunst/dunstrc".source = ./dunstrc;

  # Hyprland wallpaper
  xdg.configFile."hypr/hyprpaper.conf".source = ./hyprpaper.conf;
  xdg.configFile."hypr/wallpaper.jpg".source = ./wallpaper.jpg;
}
