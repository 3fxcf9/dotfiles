{
  lib,
  config,
  ...
}: {
  services.openssh = {
    enable = true;
    ports = [26];

    settings = {
      PasswordAuthentication = true; # TODO: Setup keys and turn off
      PermitRootLogin = "no";
    };

    # Fix LPE vulnerability with sudo use SSH_AUTH_SOCK: https://github.com/NixOS/nixpkgs/issues/31611
    authorizedKeysFiles = lib.mkForce ["/etc/ssh/authorized_keys.d/%u"];
  };

  networking.firewall.allowedTCPPorts = [26];
}
