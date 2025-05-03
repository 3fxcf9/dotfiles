{
  pkgs,
  unstable,
  config,
  inputs,
  ...
}: let
  mailConfig = import "${builtins.toString inputs.nix-secrets}/email/${config.var.hostname}.nix" {
    config = config;
    pkgs = pkgs;
  };
in {
  programs.thunderbird = {
    enable = true;
    package = unstable.thunderbird;
    profiles.${config.var.username} = {
      isDefault = true;
    };
  };
  accounts.email = mailConfig.accounts.email; # Load the thunderbird config from the nix-secrets private git repository. Here is a template on such a file:

  # {config, ...}: {
  #   accounts.email = {
  #     accounts.example = {
  #       primary = true;
  #       realName = "Name";
  #       address = "email";
  #       userName = "email";
  #       thunderbird = {
  #         enable = true;
  #         profiles = ["${config.var.username}"];
  #       };
  #       imap = {
  #         host = "imap.example.com";
  #         port = 993;
  #       };
  #       smtp = {
  #         host = "smtp.example.com";
  #         port = 587;
  #         tls.useStartTls = true;
  #       };
  #     };
  #   };
  # }
}
