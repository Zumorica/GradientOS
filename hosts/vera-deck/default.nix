{ config, lib, pkgs, ... }:

{

  imports = [
    ./backups.nix
    ./klipper.nix
    ./programs.nix
    ./mainsail.nix
    ./ustreamer.nix
    ./moonraker.nix
    ./syncthing.nix
    ./filesystems.nix
    ./secrets/default.nix
    ./hardware-configuration.nix
  ];

  networking.hostName = "vera-deck";

  gradient.substituters = {
    asiyah = "ssh-ng://nix-ssh@asiyah.gradient?priority=40";
    briah = "ssh-ng://nix-ssh@briah.gradient?priority=60";
    vera = "ssh-ng://nix-ssh@vera.gradient?priority=40";
    vera-deck-oled = "ssh-ng://nix-ssh@vera-deck-oled.gradient?priority=50";
    neith = "ssh-ng://nix-ssh@neith.lily?priority=100";
  };

  networking.hosts = with config.gradient.const.wireguard.addresses; {
    "${gradientnet.asiyah}" = [ "gradientnet" "gradient" "asiyah" ];
    "${gradientnet.briah}"  = [ "briah" ];
    "${gradientnet.miracle-crusher}" = [ "vera" ];
    "${gradientnet.vera-deck-oled}" = [ "deck-oled" ];
    "${gradientnet.vera-laptop}" = [ "laptop" ];
    "${lilynet.asiyah}" = [ "lilynet" ];
    "${lilynet.neith-deck}" = [ "neith" "lily" ];
  };

}