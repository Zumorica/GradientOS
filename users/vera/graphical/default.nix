{ pkgs, ... }:

{

  imports = [
    ./konsole/default.nix
  ];

  home.packages = with pkgs; [
    stable.gimp-with-plugins
    lxqt.pavucontrol-qt
    whatsapp-for-linux
    kdePackages.okular
    libreoffice-fresh
    google-chrome
    moonlight-qt
    qbittorrent
    smartgithg
    obs-studio
    bitwarden
    tdesktop
    audacity
    inkscape
    qpwgraph
    discord
    anydesk
    vscode
    ventoy
    krita
    carla
    kate
    vmpk
    peek
    vlc
    mpv
  ];

}