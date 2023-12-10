{ pkgs, ... }:

{

  home.packages = with pkgs; [
    lxqt.pavucontrol-qt
    libsForQt5.okular
    libsForQt5.falkon
    gimp-with-plugins
    google-chrome
    moonlight-qt
    qbittorrent
    chromium
    tdesktop
    rustdesk
    qpwgraph
    anydesk
    discord
    spotify
    kate
    vlc
    mpv
  ];

}