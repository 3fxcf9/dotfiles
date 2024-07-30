{
  inputs,
  config,
  pkgs,
  ...
}: let
  syncthingConfig = import "${builtins.toString inputs.nix-secrets}/syncthing/${config.var.hostname}.nix" {
    config = config;
    pkgs = pkgs;
  };
in {
  # networking.firewall.allowedTCPPorts = [8384 22000];
  # networking.firewall.allowedUDPPorts = [22000 21027];
  services.syncthing = syncthingConfig.services.syncthing; # Load syncthing config from the nix-secrets private git repository. Here is a template on such a file:
  # {
  #   config,
  #   pkgs,
  #   ...
  # }: {
  #   services.syncthing = {
  #     enable = true;
  #     user = config.var.username;
  #     dataDir = config.var.homeDirectory;
  #     configDir = "${config.var.homeDirectory}/.config/syncthing";
  #     overrideDevices = true; # overrides any devices added or deleted through the WebUI
  #     overrideFolders = true; # overrides any folders added or deleted through the WebUI
  #     settings = {
  #       gui = {
  #         user = config.var.username;
  #         password = "change";
  #       };
  #       devices = {
  #         "device-name" = {id = "DEVICE-ID";};
  #       };
  #       folders = {
  #         "label" = {
  #           id = "share-id";
  #           path = "/home/${config.var.username}/path/to/folder";
  #           devices = ["device-name"];
  #           versioning = {
  #             type = "trashcan";
  #             params.cleanoutDays = "30";
  #           };
  #         };
  #       };
  #       openDefaultPorts = true;
  #     };
  #   };
  # }
}
