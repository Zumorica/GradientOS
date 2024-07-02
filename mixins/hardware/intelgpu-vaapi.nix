{ pkgs, ... }:
{

  # Enable low-power encoding
  boot.extraModprobeConfig = ''
    options i915 enable_guc=2
  '';

  hardware.graphics = {
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