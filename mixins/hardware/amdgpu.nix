{ pkgs, ... }:

{

  environment.variables.AMD_VULKAN_ICD = "RADV";

  hardware.opengl.extraPackages = with pkgs; [
    vaapiVdpau
    libvdpau-va-gl
    rocm-opencl-icd
    rocm-opencl-runtime
  ];

}