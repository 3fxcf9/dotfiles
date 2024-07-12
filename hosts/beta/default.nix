{inputs, ...}: {
  imports = [
    ./hardware-configuration.nix
    inputs.disko.nixosModules.disko
    ./disk-config.nix

    # Common config
    ../common/core

    # Optionnal
    ../common/optional/services/openssh.nix
    ../common/optional/pipewire.nix
    ../common/optional/docker.nix
    ../common/optional/services/printing.nix
    ../common/optional/rtl-sdr.nix
    ../common/optional/hyprland.nix

    # Users
    ../../users/moi
  ];

  networking = {
    hostName = "beta";
    networkmanager.enable = true;
  };

  boot.loader.systemd-boot.enable = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
