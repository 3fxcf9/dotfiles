{pkgs, ...}: {
  home.packages = with pkgs; [
    signal-desktop
  ];

  nixpkgs.overlays = [
    # Make Signal desktop display
    (self: super: {
      signal-desktop = super.signal-desktop.overrideAttrs (old: {
        preFixup =
          old.preFixup
          + ''
            gappsWrapperArgs+=(
              --add-flags "--enable-features=UseOzonePlatform"
              --add-flags "--ozone-platform=wayland"
            )
          '';
      });
    })
  ];
}
