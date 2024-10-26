{pkgs, ...}: {
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
  environment.systemPackages = with pkgs; [usbutils];
}
