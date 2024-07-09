{
  inputs,
  outputs,
  pkgs,
  configLib,
  ...
}: {
  imports =
    (configLib.scanPaths ./.)
    ++ [inputs.home-manager.nixosModules.home-manager];

  console = {
    font = "Lat2-Terminus16";
  };

  documentation.dev.enable = true;

  security.sudo.extraConfig = ''
    Defaults timestamp_timeout=60 # only ask for password every hour
  '';

  # TODO: Find better location to enable dconf
  programs.dconf.enable = true;

  home-manager.extraSpecialArgs = {inherit inputs outputs;};

  nixpkgs.config.allowUnfree = false;

  hardware.enableRedistributableFirmware = true;
}
