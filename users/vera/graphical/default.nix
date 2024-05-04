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
    bitwarden
    tdesktop
    audacity
    inkscape
    qpwgraph
    firefox
    discord
    anydesk
    vscode
    ventoy
    nheko
    krita
    carla
    kate
    vmpk
    peek
    vlc
    mpv
  ];

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      obs-vkcapture
      obs-vaapi
    ];
  };

}