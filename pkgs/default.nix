flake: self: super:
with self; {
  cadence = super.cadence.override {
    libjack2 = super.pipewire.jack;
  };

  discord = super.discord.override {
    withOpenASAR = true;
  };

  steam = super.steam.override {
    extraPkgs = pkgs: with pkgs; [
      # Extra Steam game dependencies go here.
      cups
      ffmpeg
      fluidsynth
      (runCommand "soundfont-fluid-fixed" { } ''
        mkdir -p "$out/share/soundfonts"
        ln -sf ${soundfont-fluid}/share/soundfonts/FluidR3_GM2-2.sf2 $out/share/soundfonts/FluidR3_GM.sf2
      '')
    ];
  };

  chromium = super.chromium.override {
    enableWideVine = true;
  };

  appimage-run = super.appimage-run.override {
    appimageTools = appimageTools // {
      defaultFhsEnvArgs = appimageTools.defaultFhsEnvArgs // { unshareIpc = false; unsharePid = false; };
    };
  };

  gradient-generator = flake.inputs.gradient-generator.packages.${system}.default;

  gradientos-upgrade-switch = super.callPackage ./scripts/gradientos-upgrade-switch.nix { };
  gradientos-upgrade-boot = super.callPackage ./scripts/gradientos-upgrade-boot.nix { };
  gradientos-upgrade-test = super.callPackage ./scripts/gradientos-upgrade-test.nix { };

  # Stable nixpkgs overlay.
  stable-2211 = import flake.inputs.nixpkgs-stable-2211 {
    inherit system;
    config.allowUnfree = true;
  };
}