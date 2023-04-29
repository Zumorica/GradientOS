{ pkgs, ... }:

{

  imports = [
    ./konsole
  ];

  home.packages = with pkgs; [
    lxqt.pavucontrol-qt
    whatsapp-for-linux
    libsForQt5.okular
    libreoffice-fresh
    jetbrains.rider
    retroarchFull
    google-chrome
    prismlauncher
    moonlight-qt
    qbittorrent
    xivlauncher
    smartgithg
    bitwarden
    tdesktop
    syncplay
    rustdesk
    cadence
    discord
    anydesk
    vscode
    ventoy
    gimp
    kate
    vlc
    mpv
  ];

}