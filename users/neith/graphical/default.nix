{ pkgs, ... }:

{

  home.packages = with pkgs; [
    lxqt.pavucontrol-qt
    # moonlight-qt TODO: Broken on latest nixpkgs, check
    libsForQt5.okular
    libsForQt5.falkon
    gimp-with-plugins
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