{pkgs, ...}: {
  hardware.rtl-sdr.enable = true;
  environment.systemPackages = builtins.attrValues {
    inherit
      (pkgs)
      rtl-sdr
      dump1090
      gqrx
      ;
  };
}
