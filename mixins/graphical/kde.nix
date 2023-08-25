{ pkgs, ... }:

{

  # Enable the KDE Plasma Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  services.xserver.desktopManager.plasma5.useQtScaling = true;

  programs.kdeconnect.enable = true;

  programs.gnupg.agent.pinentryFlavor = "qt";

  services.power-profiles-daemon.enable = true;
  
  environment.systemPackages = with pkgs; [
    libsForQt5.powerdevil
    libsForQt5.discover
    libsForQt5.sddm-kcm
    pinentry-qt
  ];

}