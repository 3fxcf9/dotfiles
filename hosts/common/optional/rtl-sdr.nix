{pkgs, ...}: {
  hardware.rtl-sdr.enable = true;
  environment.systemPackages = builtins.attrValues {
    inherit
      (pkgs)
      dump1090
      gqrx
      ;
  };
}
