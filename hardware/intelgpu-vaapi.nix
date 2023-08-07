{ pkgs, ... }:
{

  hardware.opengl = {
    extraPackages = with pkgs; [
      intel-vaapi-driver.override { enableHybridCodec = true; }
      intel-compute-runtime
      intel-media-driver
      intel-media-sdk
      libvdpau-va-gl
      vaapiVdpau
    ];
    extraPackages32 = with pkgs.driversi686Linux; [
      intel-vaapi-driver.override { enableHybridCodec = true; }
      intel-media-driver
      libvdpau-va-gl
      vaapiVdpau
    ];
  };

}