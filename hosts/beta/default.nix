{
  inputs,
  pkgs,
  config,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    inputs.disko.nixosModules.disko
    ./disk-config.nix

    # Variables
    ./variables.nix

    # Required config
    ../common/core

    # Optionnal
    ../common/optional/services/openssh.nix
    ../common/optional/pipewire.nix
    ../common/optional/docker.nix
    ../common/optional/services/printing.nix
    ../common/optional/rtl-sdr.nix
    ../common/optional/hyprland.nix
  ];

  boot = {
    tmp.cleanOnBoot = true;
    loader.systemd-boot.enable = true;
  };

  networking = {
    hostName = config.var.hostname;
    networkmanager.enable = true;
  };

  users.users.${config.var.username} = {
    password = "nixos";
    shell = pkgs.zsh;
    isNormalUser = true;
    description = "${config.var.username} account";
    extraGroups = ["networkmanager" "wheel" "docker" "plugdev"];
  };
  home-manager.users.moi = import ./home.nix;

  services.xserver = {
    enable = true;
    xkb.layout = config.var.keyboardLayout;
    xkb.variant = config.var.keyboardLayoutVariant;
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "24.05";
}
