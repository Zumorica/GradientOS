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

  gradient.substituters = {
    asiyah = "ssh-ng://nix-ssh@asiyah.gradient?priority=40";
    briah = "ssh-ng://nix-ssh@briah.gradient?priority=60";
    vera-deck = "ssh-ng://nix-ssh@vera-deck.gradient?priority=45";
    vera = "ssh-ng://nix-ssh@vera.gradient?priority=40";
    neith = "ssh-ng://nix-ssh@neith.lily?priority=100";
  };

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