{ pkgs, ... }:

{

  # Enable the KDE Plasma Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  services.xserver.desktopManager.plasma5.useQtScaling = true;

  programs.kdeconnect.enable = true;

  programs.gnupg.agent.pinentryFlavor = "qt";
  
  environment.systemPackages = with pkgs; [
    pinentry-qt
    libsForQt5.discover
    libsForQt5.sddm-kcm
  ];

}