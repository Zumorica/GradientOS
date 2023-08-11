/* Taken and modified from https://github.com/linuxmobile/kaku/blob/main/pkgs/xwaylandvideobridge/default.nix */
{ stdenv, fetchFromGitLab, fetchpatch, cmake, pkg-config, extra-cmake-modules
, qt5, libsForQt5, wrapQtAppsHook, }:
stdenv.mkDerivation {
  pname = "xwaylandvideobridge";
  version = "unstable-2023-05-28";

  src = fetchFromGitLab {
    domain = "invent.kde.org";
    owner = "system";
    repo = "xwaylandvideobridge";
    rev = "16091a997d40eb9e5a46f3f0eecceff8fe348c87";
    hash = "sha256-Wzd48cIB/MCbzjBBfdmUfjA43oG0jtg7tWFl91FaDtk=";
  };

  nativeBuildInputs = [ cmake extra-cmake-modules pkg-config wrapQtAppsHook ];

  patches = [
    (fetchpatch {
      url =
        "https://aur.archlinux.org/cgit/aur.git/plain/cursor-mode.patch?h=xwaylandvideobridge-cursor-mode-2-git";
      hash = "sha256-649kCs3Fsz8VCgGpZ952Zgl8txAcTgakLoMusaJQYa4";
    })
  ];

  buildInputs = [
    qt5.qtbase
    qt5.qtquickcontrols2
    qt5.qtx11extras
    libsForQt5.kdelibs4support
    (libsForQt5.kpipewire.overrideAttrs (_oldAttrs: {
      version = "unstable-2023-05-28";

      src = fetchFromGitLab {
        domain = "invent.kde.org";
        owner = "plasma";
        repo = "kpipewire";
        rev = "176ac3da53dd09cc4d4ce37910c62c5cfb5dd190"; # Plasma/5.27 branch
        hash = "sha256-u+CGk/jm5pHTPJYwKHwHc01c9E+ElsfKkzYg5NfIaJ8=";
      };
    }))
  ];
}