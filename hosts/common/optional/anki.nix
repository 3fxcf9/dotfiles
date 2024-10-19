{pkgs, ...}: {
  environment.systemPackages = [
    pkgs.anki-bin
  ];
}
