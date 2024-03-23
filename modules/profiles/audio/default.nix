{ config, lib, pkgs, ... }:
let
  cfg = config.gradient;
in
{
  imports = [

  ];

  options = {
    gradient.profiles.audio.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Whether to enable the GradientOS audio profile.
        Enables Pipewire, and adds ALSA, JACK and PulseAudio support for it.
      '';
    };
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.profiles.audio.enable {
      sound.enable = true;
      
      hardware.pulseaudio.enable = lib.mkForce false;
    
      services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        jack.enable = true;
        wireplumber.enable = true;
      };

      environment.systemPackages = [
        pkgs.jack-matchmaker
      ];

      # Very permissive limits... But it fixes a race condition!
      systemd.services.wireplumber = {
        startLimitBurst = 100;
        startLimitIntervalSec = 60;
      };
      systemd.user.services.wireplumber = {
        startLimitBurst = 100;
        startLimitIntervalSec = 60;
      };
    })
  ];

}