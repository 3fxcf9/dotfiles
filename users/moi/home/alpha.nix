{
  inputs,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./common/core

    ./common/optionnal/desktop
    ./common/optionnal/signal-desktop
    ./common/optionnal/librewolf
    ./common/optionnal/neovim
  ];

  home = {
    username = "moi";
    homeDirectory = "/home/moi";
  };

  home.keyboard = null;
}
