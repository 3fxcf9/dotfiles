{pkgs, ...}: {
  home.packages = with pkgs; [figlet rust-motd];
  xdg.configFile."rust-motd/config.toml".source = ./rust-motd.toml;
}
