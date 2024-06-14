{pkgs, ...}: {
  home.packages = with pkgs; [hyprpaper];

  xdg.enable = true;
  xdg.configFile."xkb/symbols/ergol".source = ./ergol.xkb;
  xdg.configFile."waybar/scripts/sonnerie".source = ./sonnerie;
  xdg.configFile."hypr/hyprpaper.conf".source = ./hyprpaper.conf;
  xdg.configFile."hypr/wallpaper.jpg".source = ./wallpaper.jpg;
  xdg.configFile."rust-motd/config.toml".source = ./rust-motd.toml;
  xdg.configFile."dunst/dunstrc".source = ./dunstrc;
}
