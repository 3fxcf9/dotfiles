{
  inputs,
  config,
  ...
}: let
  secretsDirectory = builtins.toString inputs.nix-secrets;
in {
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  sops = {
    defaultSopsFile = "${secretsDirectory}/secrets.yaml";
    validateSopsFiles = false;

    age = {
      sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
    };

    secrets = {
      "${config.var.username}/age_key" = {
        owner = config.users.users.${config.var.username}.name;
        inherit (config.users.users.${config.var.username}) group;
        path = "${config.var.homeDirectory}/.config/sops/age/keys.txt";
      };

      "${config.var.username}/password".neededForUsers = true;
    };
  };
}
