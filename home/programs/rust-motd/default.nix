{pkgs, ...}: {
  xdg.configFile."rust-motd/config.toml".source = ./rust-motd.toml;
}
