{ pkgs, ... }:

{

  home.packages = with pkgs; [
    stable.gimp-with-plugins
    kdePackages.kolourpaint
    lxqt.pavucontrol-qt
    # moonlight-qt TODO: Broken on latest nixpkgs, check
    kdePackages.okular
    kdePackages.falkon
    google-chrome
    qbittorrent
    chromium
    tdesktop
    qpwgraph
    anydesk
    discord
    spotify
    kate
    vlc
    mpv
  ];

}