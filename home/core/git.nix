{
  pkgs,
  lib,
  config,
  ...
}: {
  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    userName = config.var.git.username;
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
