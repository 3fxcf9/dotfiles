{unstable, ...}: {
  home.packages = with unstable; [
    signal-desktop
  ];

  # Signal-desktop overlay in hosts/common/core/default.nix
}
