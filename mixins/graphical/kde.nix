{ pkgs, ... }:

{

  # Enable the KDE Plasma Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.xserver.desktopManager.plasma5.useQtScaling = true;

  programs.kdeconnect.enable = true;

  services.power-profiles-daemon.enable = true;
  
  environment.systemPackages = with pkgs; [
    kdePackages.powerdevil
    kdePackages.kio-admin
    kdePackages.discover
    kdePackages.sddm-kcm
    pinentry-qt
  ];

}