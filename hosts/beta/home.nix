{
  pkgs,
  config,
  ...
}: {
  imports = [
    ./variables.nix

    ../../home/core

    # Programs
    ../../home/programs/alacritty
    ../../home/programs/neovim
    ../../home/programs/btop
    ../../home/programs/zathura
    ../../home/programs/librewolf
    ../../home/programs/signal-desktop

    # Scripts
    # ../../home/scripts/default.nix # All scripts

    # System (Desktop environment like stuff)
    ../../home/system/hyprland
    ../../home/system/waybar
    ../../home/system/dunst
    ../../home/system/gtk
    ../../home/system/tofi
  ];

  home = {
    username = config.var.username;
    homeDirectory = config.var.homeDirectory;

    # Import wallpapers into $HOME/.wallpapers
    file.".wallpapers" = {
      recursive = true;
      source = ../../themes/wallpapers;
    };

    stateVersion = "24.05";
  };

  programs.home-manager.enable = true;
}