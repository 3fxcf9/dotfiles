{
  outputs,
  lib,
  config,
  ...
}: {
  programs.ssh = {
    enable = true;
    matchBlocks = {
      "git" = {
        host = "gitlab.com github.com";
        user = "git";
        forwardAgent = true;
        identitiesOnly = true;
        identityFile = [
          "~/.ssh/id_${config.var.username}"
        ];
      };
    };
  };
}
