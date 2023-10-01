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
    anydesk
    cadence
    discord
    spotify
    kate
    vlc
    mpv
  ];

}