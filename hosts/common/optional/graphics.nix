{
  pkgs,
  lib,
  ...
}: {
  environment.systemPackages = with pkgs; [
    radeontop # Like htop, but for AMD GPUs
    nvtopPackages.amd # nvtop for AMD GPUs
  ];

  # Load amdgpu at stage 1
  boot.initrd.kernelModules = ["amdgpu"];
  boot.kernelParams = [
    # AMD CPU scaling
    # https://www.kernel.org/doc/html/latest/admin-guide/pm/amd-pstate.html
    # https://wiki.archlinux.org/title/CPU_frequency_scaling#amd_pstate
    # On recent AMD CPUs this can be more energy efficient.
    "amd_pstate=guided"

    # Load amdgpu at stage 1
    "amdgpu"

    # With BIOS version 1.12 and the IOMMU enabled, the amdgpu driver
    # either crashes or is not able to attach to the GPU depending on
    # the kernel version. I've seen no issues with the IOMMU disabled.
    #
    # BIOS version 1.13 fixes the IOMMU issues, but we leave the IOMMU
    # in software mode to avoid a sad experience for those people that drew
    # the short straw when they bought their laptop.
    #
    # Do not set iommu=off, because this will cause the SD-Card reader
    # driver to kernel panic.
    "iommu=soft"
  ];

  # AMD GPU
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      # VA-API and VDPAU
      vaapiVdpau

      # AMD ROCm OpenCL runtime
      rocmPackages.clr
      rocmPackages.clr.icd

      # AMDVLK drivers can be used in addition to the Mesa RADV drivers.
      amdvlk
    ];
    extraPackages32 = with pkgs; [driversi686Linux.amdvlk];
  };

  environment.variables = {
    # VAAPI and VDPAU config for accelerated video.
    # See https://wiki.archlinux.org/index.php/Hardware_video_acceleration
    "VDPAU_DRIVER" = "radeonsi";
    "LIBVA_DRIVER_NAME" = "radeonsi";
  };
  # Most software has the HIP libraries hard-coded. Workaround:
  systemd.tmpfiles.rules = [
    "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
  ];

  services.xserver.videoDrivers = lib.mkDefault ["modesetting"];
}
