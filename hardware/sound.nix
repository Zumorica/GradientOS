{ lib, pkgs, ... }:

let
  jack-libs = pkgs.runCommand "jack-libs" {} ''
      mkdir -p "$out/lib"
      ln -s "${pkgs.pipewire.jack}/lib" "$out/lib/pipewire"
    '';
in {
  hardware.pulseaudio.enable = lib.mkForce false;
  
  security.rtkit.enable = true;
  
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };

  sound.enable = true;
  
  environment.systemPackages = [
    jack-libs
  ];
}