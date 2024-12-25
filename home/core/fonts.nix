{pkgs, ...}: {
  fonts.fontconfig.enable = true;
  home.packages = [
    pkgs.monaspace
    pkgs.nerd-fonts.monaspace
    pkgs.nerd-fonts.symbols-only
    pkgs.manrope
  ];
}
