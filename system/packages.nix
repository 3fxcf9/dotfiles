{
  inputs,
  config,
  pkgs,
  ...
}: {
  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;
    };
    zsh = {enable = true;};
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    # Utils
    git
    wget
    neovim
    killall
    neofetch
    htop
    btop
    polkit
    gnome.gnome-disk-utility
    figlet
    rust-motd

    # GUI
    dunst
    libnotify
    hyprland
    tofi
    waybar
    wayland-protocols
    wayland-utils
    wlroots
    nwg-displays

    # Build
    cmake
    gcc
    meson
    ninja
  ];

  fonts.packages = with pkgs; [monaspace nerdfonts];
}
