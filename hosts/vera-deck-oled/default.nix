{ lib, ... }:
{

  imports = [
    ./secrets
    ./programs.nix
    ./wireguard.nix
    ./syncthing.nix
    ./filesystems.nix
    ./hardware-configuration.nix
  ];

  networking.hostName = "vera-deck-oled";

  gradient.profiles.gaming.enable = true;

  # Use Jovian's steam deck UI autostart.
  services.xserver.displayManager.sddm.enable = lib.mkForce false;
  jovian.steam.autoStart = true;
  jovian.steam.user = "vera";
  jovian.decky-loader.user = "vera";
  jovian.steam.desktopSession = "plasma";

}