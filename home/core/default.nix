{
  lib,
  pkgs,
  ...
}: let
  scanPaths = path:
    builtins.map
    (f: (path + "/${f}"))
    (builtins.attrNames
      (lib.attrsets.filterAttrs
        (
          path: _type: (_type == "directory") || ((path != "default.nix") && (lib.strings.hasSuffix ".nix" path))
        )
        (builtins.readDir path)));
in {
  imports = scanPaths ./.;

  xdg.enable = true;
  xdg.portal.config.common.default = ["gnome"];

  home = {
    stateVersion = lib.mkDefault "23.05";
    sessionPath = [
      "$HOME/.local/bin"
    ];
    sessionVariables = {
      SHELL = "zsh";
      TERM = "wezterm";
      TERMINAL = "wezterm";
      EDITOR = "nvim";
    };
  };

  home.packages = with pkgs; [
    # Utils
    xdg-utils
    fd # `find` replacement
    eza
    zoxide
    fzf
    ripgrep
    jq
    tldr
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

    # TODO: Notification
    dunst
    libnotify

    # Apps
    yazi
  ];

  nix = {
    package = lib.mkDefault pkgs.nix;
    settings = {
      experimental-features = ["nix-command" "flakes"];
      warn-dirty = false;
    };
  };

  programs = {
    home-manager.enable = true;
  };
}
