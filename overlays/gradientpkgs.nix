/*
*   Overlay with packages that can be consumed without using a GradientOS configuration.
*/
final: prev:
{
  godot-mono = prev.callPackage ../pkgs/godot-mono.nix { };

  jack-matchmaker = prev.callPackage ../pkgs/jack-matchmaker.nix { };

  starsector-gamescope-wrap = prev.callPackage ../pkgs/starsector-gamescope-wrap.nix { }; 

  tinypilot = prev.callPackage ../pkgs/tinypilot.nix { };

  # Klipper with accelerometer support. See: https://www.klipper3d.org/Measuring_Resonances.html#software-installation
  klipper = prev.klipper.overrideAttrs (finalAttrs: prevAttrs: {
    buildInputs = [
      prev.openblasCompat
      (prev.python3.withPackages (p: with p; [can cffi pyserial greenlet jinja2 markupsafe numpy matplotlib ]))
      ];
  });

  klipper-np3pro-firmware = prev.klipper-firmware.override {
    mcu = prev.lib.strings.sanitizeDerivationName "np3pro";
    firmwareConfig = ../pkgs/klipper-np3pro-firmware/config;
  };

  klipper-kusba-firmware = (prev.klipper-firmware.override {
    mcu = prev.lib.strings.sanitizeDerivationName "kusba";
    firmwareConfig = ../pkgs/klipper-kusba-firmware/config;
  }).overrideAttrs (finalAttrs: prevAttrs: {
    # Regular firmware derivation does not copy uf2 file.
    installPhase = prevAttrs.installPhase + ''
      cp out/klipper.uf2 $out/ || true
    '';
  });

}
