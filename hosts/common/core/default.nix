{
  inputs,
  outputs,
  lib,
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

  nixpkgs.config.allowUnfree = false;

  hardware.enableRedistributableFirmware = true;
}
