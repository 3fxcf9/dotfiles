{
  lib,
  pkgs,
  unstable,
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

  home.packages = with unstable; [
    # Utils
    xdg-utils
    fd # `find` replacement
    eza
    ripgrep
    # jq # already defined in home/system/waybar/default.nix
    tldr
    wget
    # curl # already defined in home/system/waybar/default.nix
    tldr
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

    # Apps
    yazi
    vimiv-qt
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
