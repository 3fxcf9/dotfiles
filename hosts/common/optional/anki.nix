{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    (writeShellScriptBin "anki" ''
      export LD_LIBRARY_PATH=${pkgs.lib.makeLibraryPath [
        pkgs.xorg.libxshmfence
        pkgs.libGL
        pkgs.libGLU
        pkgs.zlib
        pkgs.glib
      ]}:$LD_LIBRARY_PATH
      exec ${anki-bin}/bin/anki "$@"
    '')

    (makeDesktopItem {
      name = "Anki";
      exec = "anki";
      icon = "anki";
      desktopName = "Anki";
      genericName = "Flashcards";
      categories = ["Education"];
    })
  ];
}
