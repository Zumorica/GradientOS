{ pkgs, ... }:

{

  environment.variables.AMD_VULKAN_ICD = "RADV";

  systemd.packages = with pkgs; [
    lact
  ];

  hardware.graphics.extraPackages = with pkgs; [
    lact
    vaapiVdpau
    libvdpau-va-gl
    rocm-opencl-icd
    rocm-opencl-runtime
  ];

}