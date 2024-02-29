{ pkgs, ... }:

{

  home.packages = with pkgs; [
    kdePackages.kolourpaint
    lxqt.pavucontrol-qt
    # moonlight-qt TODO: Broken on latest nixpkgs, check
    kdePackages.okular
    kdePackages.falkon
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