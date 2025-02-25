{
  pkgs,
  config,
  ...
}: {
  services = {
    dbus.enable = true;
    gvfs.enable = true;
    udisks2.enable = true;
    logind.extraConfig = ''
      # don’t shutdown when power button is short-pressed
      HandlePowerKey=ignore
    '';
  };
  programs.dconf.enable = true;
  environment.systemPackages = [pkgs.usbutils config.boot.kernelPackages.perf];

  networking.firewall.allowedTCPPorts = [3680 8000]; # FIXME: Dev network port
}
