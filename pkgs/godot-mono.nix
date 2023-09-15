{ stdenv
, fetchzip
, makeWrapper
, makeDesktopItem
, steam-run
}:
stdenv.mkDerivation {
  name = "godot-mono";
  version = "4.1.1";

  src = fetchzip {
    url = "https://github.com/godotengine/godot/releases/download/4.1.1-stable/Godot_v4.1.1-stable_mono_linux_x86_64.zip";
    sha256 = "sha256-+8a/9T9zVaGKPA4+EUJ3FsgLuCSJ7BXdy+v1mQRxNcA=";
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
      --add-flags $out/bin/Godot_v4.1.1-stable_mono_linux.x86_64

    # Desktop item
    mkdir -p $out/share/applications
    cp $desktopItem/share/applications/* $out/share/applications/

  '';

}