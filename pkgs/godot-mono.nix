{ stdenv
, fetchzip
, makeWrapper
, makeDesktopItem
, steam-run
}:
let
  version = "4.1.3";
in
stdenv.mkDerivation {
  inherit version;
  name = "godot-mono";

  src = fetchzip {
    url = "https://github.com/godotengine/godot/releases/download/${version}-stable/Godot_v${version}-stable_mono_linux_x86_64.zip";
    sha256 = "sha256-QtsPXx4q0S95WATc4YM+MSocapY1G7BgdSiToX/ODzY=";
  };

  nativeBuildInputs = [ makeWrapper ];

  desktopItem = makeDesktopItem {
    name = "Godot Engine (Mono)";
    desktopName = "Godot Engine (Mono)";
    exec = "godot-mono";
    icon = "godot";
    terminal = false;
    prefersNonDefaultGPU = true;
    type = "Application";
    mimeTypes = [ "application/x-godot-project" ];
    comment = "Multi-platform 2D and 3D game engine with a feature-rich editor";
    genericName = "Libre game engine";
    categories = [ "Development" "IDE" ];
    extraConfig.StartupWMClass = "Godot";
  };

  installPhase = ''
    mkdir -p $out/bin
    cp -r ./* $out/bin
    makeWrapper ${steam-run}/bin/steam-run $out/bin/godot-mono \
      --add-flags $out/bin/Godot_v${version}-stable_mono_linux.x86_64

    # Desktop item
    mkdir -p $out/share/applications
    cp $desktopItem/share/applications/* $out/share/applications/

  '';

}