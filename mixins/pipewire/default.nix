{ lib, pkgs, ... }:

{

  hardware.pulseaudio.enable = lib.mkForce false;
  
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };

  sound.enable = true;

  environment.systemPackages = with pkgs; [
    jack-matchmaker
  ];

  # Very permissive limit... But it fixes a race condition!
  systemd.services.wireplumber = {
    startLimitBurst = 100;
    startLimitIntervalSec = 60;
  };
  systemd.user.services.wireplumber = {
    startLimitBurst = 100;
    startLimitIntervalSec = 60;
  };

}