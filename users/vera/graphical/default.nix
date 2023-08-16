{ pkgs, ... }:

{

  imports = [
    ./konsole
  ];

  home.packages = with pkgs; [
    space-station-14-launcher
    lxqt.pavucontrol-qt
    whatsapp-for-linux
    libsForQt5.okular
    libreoffice-fresh
    gimp-with-plugins
    jetbrains.rider
    retroarchFull
    google-chrome
    prismlauncher
    moonlight-qt
    qbittorrent
    xivlauncher
    smartgithg
    starsector
    obs-studio
    bitwarden
    tdesktop
    syncplay
    audacity
    inkscape
    rustdesk
    cadence
    discord
    anydesk
    vscode
    ventoy
    krita
    kate
    vmpk
    peek
    vlc
    mpv
  ];

}