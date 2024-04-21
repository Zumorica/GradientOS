{ config, lib, ... }:
{

  imports = [
    ./secrets
    ./backups.nix
    ./programs.nix
    ./syncthing.nix
    ./filesystems.nix
    ./hardware-configuration.nix
  ];

  networking.hostName = "vera-deck-oled";

  gradient.profiles.gaming.enable = true;

  # Android app support with waydroid.
  virtualisation.waydroid.enable = true;

  # Use Jovian's steam deck UI autostart.
  services.displayManager.sddm.enable = lib.mkForce false;
  jovian.steam.autoStart = true;
  jovian.steam.user = "vera";
  jovian.decky-loader.user = "vera";
  jovian.steam.desktopSession = "plasma";

  networking.hosts = with config.gradient.const.wireguard.addresses; {
    "${gradientnet.asiyah}" = [ "gradientnet" "gradient" "asiyah" ];
    "${gradientnet.briah}"  = [ "briah" ];
    "${gradientnet.miracle-crusher}" = [ "vera" ];
    "${gradientnet.vera-deck}" = [ "deck" ];
    "${gradientnet.vera-laptop}" = [ "laptop" ];
    "${lilynet.asiyah}" = [ "lilynet" ];
    "${lilynet.neith-deck}" = [ "neith" "lily" ];
  };

}