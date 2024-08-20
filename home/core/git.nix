{
  pkgs,
  config,
  ...
}: let
  sshPrivateKeyPath = config.sops.secrets."${config.var.username}/private_ssh_key".path;
  generate-ssh-pubkey = pkgs.writeShellScriptBin "generate-ssh-pubkey" ''
    ${pkgs.openssh}/bin/ssh-keygen -y -f ${sshPrivateKeyPath} > ${sshPrivateKeyPath}.pub
  '';
  generate-allowed-signers = pkgs.writeShellScriptBin "generate-allowed-signers" ''
    echo "${config.programs.git.userEmail} $(cat ${sshPrivateKeyPath}.pub)" > ${config.var.homeDirectory}/.ssh/allowed_signers
  '';
in {
  home.packages = [generate-ssh-pubkey];

  home.activation.generateSshPublicKey = config.lib.dag.entryAfter ["writeBoundary"] ''
    $DRY_RUN_CMD ${generate-ssh-pubkey}/bin/generate-ssh-pubkey
    $DRY_RUN_CMD ${generate-allowed-signers}/bin/generate-allowed-signers
  '';
  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    userName = config.var.git.username;
    signing = {
      key = "${sshPrivateKeyPath}";
      signByDefault = true;
    };
    extraConfig = {
      commit.gpgsign = true;
      gpg.format = "ssh";
      gpg.ssh.allowedSignersFile = "${config.var.homeDirectory}/.ssh/allowed_signers";
    };
    userEmail = config.var.git.email;
    aliases = {};
    extraConfig = {
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      url = {
        "ssh://git@github.com" = {
          insteadOf = "https://github.com";
        };
        "ssh://git@gitlab.com" = {
          insteadOf = "https://gitlab.com";
        };
      };
    };
    ignores = [".direnv" "result"];
  };
}
