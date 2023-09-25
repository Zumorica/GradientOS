/*
*   Overlay with packages that can be consumed without using a GradientOS configuration.
*/
final: prev:
{
  godot-mono = prev.callPackage ../pkgs/godot-mono.nix { };

  jack-matchmaker = prev.callPackage ../pkgs/jack-matchmaker.nix { };

  starsector-gamescope-wrap = prev.callPackage ../pkgs/starsector-gamescope-wrap.nix { }; 

  tinypilot = prev.callPackage ../pkgs/tinypilot.nix { };

  xwaylandvideobridge = prev.libsForQt5.callPackage ../pkgs/xwaylandvideobridge.nix { };

  klipper-np3pro-firmware = prev.klipper-firmware.override {
    mcu = prev.lib.strings.sanitizeDerivationName "np3pro";
    firmwareConfig = ../pkgs/klipper-np3pro-firmware/config;
  };

}