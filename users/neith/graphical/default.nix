{ pkgs, ... }:

{

  home.packages = with pkgs; [
    lxqt.pavucontrol-qt
    libsForQt5.okular
    retroarchFull
    google-chrome
    prismlauncher
    moonlight-qt
    qbittorrent
    xivlauncher
    tdesktop
    rustdesk
    syncplay
    anydesk
    cadence
    discord
    gimp
    vlc
    mpv
  ];

}