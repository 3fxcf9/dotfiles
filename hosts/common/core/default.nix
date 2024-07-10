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
    earlySetup = true;
    packages = with pkgs; [terminus_font];
    font = "ter-118b";
    colors = [
      "15121c"
      "cb5760"
      "999f63"
      "d4a067"
      "6c90a8"
      "776690"
      "528a9b"
      "eeffff"
      "727480"
      "cb5760"
      "999f63"
      "d4a067"
      "6c90a8"
      "776690"
      "528a9b"
      "eeffff"
    ];
  };

  environment.etc."issue".text = ''
    [1;32m>>> Welcome to \n <<<[0m

    [1;33mNixOS \m - \l - \U connected[0m

    [1;30m\d \t[0m

  '';

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
