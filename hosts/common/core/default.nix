{
  inputs,
  outputs,
  lib,
  config,
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
  imports =
    (scanPaths ./.)
    ++ [inputs.home-manager.nixosModules.home-manager];

  documentation.dev.enable = true;

  security.sudo.extraConfig = ''
    Defaults timestamp_timeout=60 # only ask for password every hour
  '';

  home-manager.extraSpecialArgs = {inherit inputs outputs;};

  nix = {
    settings = {
      trusted-users = ["root" config.var.username];
    };
  };

  nixpkgs.config.allowUnfree = false;

  # Make Signal desktop display
  # nixpkgs.overlays = [
  #   (final: prev: {
  #     signal-desktop = prev.signal-desktop.overrideAttrs (old: {
  #       preFixup =
  #         old.preFixup
  #         + ''
  #           gappsWrapperArgs+=(
  #             --add-flags "--enable-features=UseOzonePlatform"
  #             --add-flags "--ozone-platform=wayland"
  #           )
  #         '';
  #     });
  #   })
  # ];

  hardware.enableRedistributableFirmware = true;

  boot.kernel.sysctl."kernel.sysrq" = 502;
}
