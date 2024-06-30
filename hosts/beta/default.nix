{
  inputs,
  configLib,
  ...
}: {
  imports =
    [
      ./hardware-configuration.nix
      inputs.disko.nixosModules.disko
      ./disk-config.nix
    ]
    ++ (map configLib.relativeToRoot [
      # Common config
      "hosts/common/core"

      # Optionnal
      "hosts/common/optional/services/openssh.nix"
      "hosts/common/optional/pipewire.nix"
      "hosts/common/optional/docker.nix"
      "hosts/common/optional/services/printing.nix"

      # Users
      "users/moi"
      #"users/public"
    ]);

  networking = {
    hostName = "beta";
    networkmanager.enable = true;
  };

  boot.loader.systemd-boot.enable = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
