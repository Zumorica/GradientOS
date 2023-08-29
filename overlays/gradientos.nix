/*
*   Overlay for systems running a GradientOS-based configuration. 
*   Includes some package overrides and GradientOS-specific scripts.
*/
flake: final: prev:
let
  steam-override = {
    extraPkgs = pkgs: with pkgs; [
      # Extra Steam game dependencies go here.
      ffmpeg-full
      cups

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
in {
  cadence = prev.cadence.override {
    libjack2 = prev.pipewire.jack;
  };

  discord = prev.discord.override {
    withOpenASAR = true;
  };

  steam = prev.steam.override steam-override;
  steam-original-fixed = final.unstable.steam.override steam-override;
  steam-deck-client = prev.callPackage ../pkgs/steam-deck-client.nix { };

  chromium = prev.chromium.override {
    enableWideVine = true;
  };

  appimage-run = prev.appimage-run.override {
    appimageTools = prev.appimageTools // {
      defaultFhsEnvArgs = prev.appimageTools.defaultFhsEnvArgs // { unshareIpc = false; unsharePid = false; };
    };
  };
  
  gradient-generator = flake.inputs.gradient-generator.packages.${prev.system}.default;

  gradientos-colmena = prev.callPackage ../pkgs/scripts/gradientos-colmena.nix { };
  gradientos-upgrade-switch = prev.callPackage ../pkgs/scripts/gradientos-upgrade-switch.nix { };
  gradientos-upgrade-boot = prev.callPackage ../pkgs/scripts/gradientos-upgrade-boot.nix { };
  gradientos-upgrade-test = prev.callPackage ../pkgs/scripts/gradientos-upgrade-test.nix { };

  nix-gaming = flake.inputs.nix-gaming.packages.${prev.system};

  # Unmodified unstable nixpkgs overlay.
  unstable = import flake.inputs.nixpkgs {
    inherit (prev) system;
    config.allowUnfree = true;
  };

  # Stable 22.11 nixpkgs overlay.
  stable-2211 = import flake.inputs.nixpkgs-stable-2211 {
    inherit (prev) system;
    config.allowUnfree = true;
  };

  # Stable 23.05 nixpkgs overlay.
  stable-2305 = import flake.inputs.nixpkgs-stable-2305 {
    inherit (prev) system;
    config.allowUnfree = true;
  };
}