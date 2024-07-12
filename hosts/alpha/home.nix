{
  pkgs,
  config,
  ...
}: {
  imports = [
    ./variables.nix

    ../../home/core

    # Programs
    ../../home/programs/neovim
    ../../home/programs/librewolf
    ../../home/programs/signal-desktop

    # Scripts
    # ../../home/scripts # All scripts

    # System (Desktop environment like stuff)
    ../../home/system/desktop
  ];

  home = {
    username = config.var.username;
    homeDirectory = config.var.homeDirectory;

    # Import wallpapers into $HOME/wallpapers
    file."wallpapers" = {
      recursive = true;
      source = ../../themes/wallpapers;
    };

    stateVersion = "24.05";
  };

  programs.home-manager.enable = true;
}
