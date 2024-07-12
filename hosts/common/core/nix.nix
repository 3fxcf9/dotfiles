{
  inputs,
  config,
  lib,
  ...
}: {
  system.autoUpgrade =
    if config.var.autoUpgrade
    then {
      enable = true;
      dates = "04:00";
      flake = "${config.var.configDirectory}";
      flags = ["--update-input" "nixpkgs" "--commit-lock-file"];
      allowReboot = false;
    }
    else {};

  nix = {
    # This will add each flake input as a registry
    # To make nix3 commands consistent with your flake
    registry = lib.mapAttrs (_: value: {flake = value;}) inputs;

    # This will add your inputs to the system's legacy channels
    # Making legacy nix commands consistent as well, awesome!
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

    settings = {
      # See https://jackson.dev/post/nix-reasonable-defaults/
      connect-timeout = 5;
      log-lines = 25;
      min-free = 128000000; # 128MB
      max-free = 1000000000; # 1GB

      # Deduplicate and optimize nix store
      auto-optimise-store = true;

      experimental-features = ["nix-command" "flakes"];
      warn-dirty = false;

      substituters = ["https://hyprland.cachix.org"];
      trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      ];
    };

    # Garbage collection
    gc =
      if config.var.autoGarbageCollector
      then {
        automatic = true;
        persistent = true;
        dates = "weekly";
        options = "--delete-older-than 7d";
      }
      else {};
  };
}
