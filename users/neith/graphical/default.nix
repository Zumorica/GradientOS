{ pkgs, ... }:

{

  home.packages = with pkgs; [
    stable.gimp-with-plugins
    kdePackages.kolourpaint
    lxqt.pavucontrol-qt
    kdePackages.okular
    google-chrome
    moonlight-qt
    qbittorrent
    chromium
    tdesktop
    qpwgraph
    firefox
    discord
    spotify
    carla
    kate
    vlc
    mpv
  ];

}