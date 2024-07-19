{
  pkgs,
  inputs,
  config,
  ...
}: let
  secretsDirectory = builtins.toString inputs.nix-secrets;
in {
  imports = [inputs.sops-nix.homeManagerModules.sops];

  home.packages = with pkgs; [sops age];

  sops = {
    age.keyFile = "/home/${config.var.username}/.config/sops/age/keys.txt";
    defaultSopsFile = "${secretsDirectory}/secrets.yaml";
    secrets = {
      "${config.var.username}/private_ssh_key" = {
        path = "${config.var.homeDirectory}/.ssh/id_${config.var.username}";
      };
    };
  };

  systemd.user.services.mbsync.Unit.After = ["sops-nix.service"];
}
