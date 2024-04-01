{ pkgs, ... }:

{

  home.packages = with pkgs; [
    stable.gimp-with-plugins
    kdePackages.kolourpaint
    lxqt.pavucontrol-qt
    kdePackages.okular
    kdePackages.falkon
    google-chrome
    moonlight-qt
    qbittorrent
    chromium
    tdesktop
    qpwgraph
    anydesk
    discord
    spotify
    carla
    kate
    vlc
    mpv
  ];

}