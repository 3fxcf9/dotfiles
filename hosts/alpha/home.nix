{config, ...}: {
  imports = [
    ./variables.nix

    # Required
    ../../home/core

    # Programs
    ../../home/programs/alacritty
    ../../home/programs/wezterm
    ../../home/programs/btop
    ../../home/programs/zathura
    ../../home/programs/firefox
    ../../home/programs/qutebrowser
    ../../home/programs/signal-desktop
    ../../home/programs/texlive
    ../../home/programs/zed-editor
    ../../home/programs/rust

    # Scripts
    # ../../home/scripts/default.nix # All scripts

    # System (Desktop environment like stuff)
    ../../home/system/hyprland
    ../../home/system/waybar
    ../../home/system/dunst
    ../../home/system/gtk
    ../../home/system/tofi
    ../../home/system/mime
    ../../home/system/batsignal
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
