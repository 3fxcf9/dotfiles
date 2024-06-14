{
  config,
  pkgs,
  ...
}: {
  networking = {
    hostName = "stdmain";
    networkmanager.enable = true;
    firewall = {
      enable = true;
      checkReversePath = false;
      allowedTCPPorts = [22];
    };
    #nameservers = [
    #  "1.1.1.1#one.one.one.one"
    #  "1.0.0.1#one.one.one.one"
    #];
  };

  #services.resolved = {
  #  enable = true;
  #  dnssec = "true";
  #  domains = [ "~." ];
  #  fallbackDns = [
  #    "1.1.1.1#one.one.one.one"
  #    "1.0.0.1#one.one.one.one"
  #  ];
  #};
}
