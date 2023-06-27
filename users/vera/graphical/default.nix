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
    gimp-with-plugins
    jetbrains.rider
    retroarchFull
    google-chrome
    prismlauncher
    moonlight-qt
    qbittorrent
    xivlauncher
    smartgithg
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