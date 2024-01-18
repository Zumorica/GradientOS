{ pkgs, ... }:

{

  imports = [
    ./konsole/default.nix
  ];

  home.packages = with pkgs; [
    lxqt.pavucontrol-qt
    # moonlight-qt TODO: Broken on latest nixpkgs, check
    whatsapp-for-linux
    libsForQt5.okular
    libreoffice-fresh
    gimp-with-plugins
    google-chrome
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
    kate
    vmpk
    peek
    vlc
    mpv
  ];

}