{
  config,
  lib,
  pkgs,
  outputs,
  configLib,
  ...
}: {
  imports = configLib.scanPaths ./.;

  xdg.enable = true;

  home = {
    stateVersion = lib.mkDefault "23.05";
    sessionPath = [
      "$HOME/.local/bin"
    ];
    sessionVariables = {
      SHELL = "zsh";
      TERM = "alacritty";
      TERMINAL = "alacritty";
      EDITOR = "nvim";
    };
  };

  home.packages = with pkgs; [
    # Utils
    fd
    eza
    fzf
    ripgrep
    jq
    tldr
    # ssh
    wget
    curl
    htop
    btop
    ncdu # TUI disk usage
    killall
    coreutils
    findutils # `find` command
    pciutils
    usbutils
    fastfetch
    zip
    unzip
    wget

    # TODO: Configure
    figlet
    rust-motd

    # TODO: Notification
    dunst
    libnotify

    # Apps
    yazi
  ];

  nix = {
    package = lib.mkDefault pkgs.nix;
    settings = {
      experimental-features = ["nix-command" "flakes" "repl-flake"];
      warn-dirty = false;
    };
  };

  programs = {
    home-manager.enable = true;
  };
}
