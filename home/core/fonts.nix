{unstable, ...}: {
  fonts.fontconfig.enable = true;
  home.packages = with unstable; [
    monaspace
    nerd-fonts.monaspace
    nerd-fonts.symbols-only
    manrope
  ];
}
