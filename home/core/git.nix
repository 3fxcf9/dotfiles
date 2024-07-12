{
  pkgs,
  lib,
  config,
  ...
}: {
  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    userName = "3fxcf9";
    userEmail = "123954477+3fxcf9@users.noreply.github.com";
    aliases = {};
    extraConfig = {
      init.defaultBranch = "main";
      # url = {
      #   "ssh://git@github.com" = {
      #     insteadOf = "https://github.com";
      #   };
      #   "ssh://git@gitlab.com" = {
      #     insteadOf = "https://gitlab.com";
      #   };
      # };
    };
    ignores = [".direnv" "result"];
  };
}
