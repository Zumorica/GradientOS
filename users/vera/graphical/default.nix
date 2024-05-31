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
    element-desktop
    google-chrome
    moonlight-qt
    qbittorrent
    smartgithg
    bitwarden
    tdesktop
    audacity
    chromium
    inkscape
    qpwgraph
    rustdesk
    firefox
    discord
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

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      obs-vkcapture
      obs-vaapi
    ];
  };

}