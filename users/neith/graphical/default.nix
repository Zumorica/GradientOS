{ pkgs, ... }:

{

  home.packages = with pkgs; [
    lxqt.pavucontrol-qt
    libsForQt5.okular
    libsForQt5.falkon
    gimp-with-plugins
    retroarchFull
    google-chrome
    prismlauncher
    moonlight-qt
    qbittorrent
    xivlauncher
    starsector
    chromium
    tdesktop
    rustdesk
    syncplay
    anydesk
    cadence
    discord
    spotify
    kate
    vlc
    mpv
  ];

}