flake: self: super:
with self;
let
  steam-override = {
    extraPkgs = pkgs: with pkgs; [
      # Extra Steam game dependencies go here.
      cups
      ffmpeg

      # Needed for Space Station 14 MIDI support.
      fluidsynth
      (runCommand "soundfont-fluid-fixed" { } ''
        mkdir -p "$out/share/soundfonts"
        ln -sf ${soundfont-fluid}/share/soundfonts/FluidR3_GM2-2.sf2 $out/share/soundfonts/FluidR3_GM.sf2
      '')

      # Needed for GTK file dialogs in certain games.
      gtk3
      pango
      cairo
      atk
      zlib
      glib
      gdk-pixbuf
    ];
    extraArgs = "-console";
  };
in rec {
  cadence = super.cadence.override {
    libjack2 = super.pipewire.jack;
  };

  discord = super.discord.override {
    withOpenASAR = true;
  };

  steam = super.steam.override steam-override;
  steam-original-fixed = unstable.steam.override steam-override;
  steam-deck-client = super.callPackage ./steam-deck-client.nix { };

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

  # Unmodified unstable nixpkgs overlay.
  unstable = import flake.inputs.nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };

  # Stable nixpkgs overlay.
  stable-2211 = import flake.inputs.nixpkgs-stable-2211 {
    inherit system;
    config.allowUnfree = true;
  };
}