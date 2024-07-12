{pkgs, ...}: {
  fonts.fontconfig.enable = true;
  home.packages = [
    pkgs.monaspace
    pkgs.nerdfonts # TODO: Override
  ];
}
