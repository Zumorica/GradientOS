{ pkgs, ... }:

{

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.desktopManager.plasma6.enable = true;

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