{ pkgs, ... }:

{

  imports = [
    ./konsole/default.nix
  ];

  home.packages = with pkgs; [
    lxqt.pavucontrol-qt
    whatsapp-for-linux
    libsForQt5.okular
    libreoffice-fresh
    gimp-with-plugins
    jetbrains.rider
    google-chrome
    moonlight-qt
    qbittorrent
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