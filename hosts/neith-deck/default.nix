{ config, lib, ... }:

{

  imports = [
    ./programs.nix
    ./syncthing.nix
    ./filesystems.nix
    ./secrets/default.nix
    ./hardware-configuration.nix
  ];

  networking.hostName = "neith-deck";

  gradient.profiles.gaming.enable = true;

  # Use Jovian's steam deck UI autostart.
  services.displayManager.sddm.enable = lib.mkForce false;
  jovian.steam.autoStart = true;
  jovian.steam.user = "neith";
  jovian.decky-loader.user = "neith";
  jovian.steam.desktopSession = "plasma";

  gradient.substituters = {
    asiyah = "ssh-ng://nix-ssh@asiyah.lily?priority=50";
    briah = "ssh-ng://nix-ssh@briah.lily?priority=60";
    vera = "ssh-ng://nix-ssh@vera.lily?priority=50";
    vera-deck = "ssh-ng://nix-ssh@vera-deck.gradient?priority=45";
    vera-deck-oled = "ssh-ng://nix-ssh@vera-deck-oled.lily?priority=50";
  };

  networking.hosts = with config.gradient.const.wireguard.addresses; {
    "${lilynet.asiyah}" = [ "lilynet" ];
    "${lilynet.miracle-crusher}" = [ "vera" ];
    "${lilynet.vera-deck}" = [ "vera-deck" ];
    "${lilynet.vera-deck-oled}" = [ "vera-deck-oled" ];
    "${slugcatnet.asiyah}" = [ "slugcatnet" ];
    "${slugcatnet.remie}" = [ "remie" ];
    "${slugcatnet.miracle-crusher}" = [ "slugcatvera" ];
    "${slugcatnet.luna}" = [ "luna" ];
  };

}