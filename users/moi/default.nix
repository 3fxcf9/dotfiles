{
  pkgs,
  lib,
  config,
  ...
}: {
  users.users.moi = {
    isNormalUser = true;
    password = "nixos";
    shell = pkgs.zsh;
    extraGroups = ["networkmanager" "wheel" "docker" "plugdev"];
    packages = [pkgs.home-manager];
  };

  home-manager.users.moi = import ./home/${config.networking.hostName}.nix;
}
