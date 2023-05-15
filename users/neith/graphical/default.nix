{ pkgs, ... }:

{

  home.packages = with pkgs; [
    lxqt.pavucontrol-qt
    libsForQt5.okular
    libsForQt5.falkon
    retroarchFull
    google-chrome
    prismlauncher
    moonlight-qt
    qbittorrent
    xivlauncher
    chromium
    tdesktop
    rustdesk
    syncplay
    anydesk
    cadence
    discord
    spotify
    kate
    gimp
    vlc
    mpv
  ];

}