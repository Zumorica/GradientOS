{ config, lib, ... }:

{

  imports = [
    ./nix.nix
    ./programs.nix
    ./syncthing.nix
    ./filesystems.nix
    ./secrets/default.nix
    ./hardware-configuration.nix
  ];

  networking.hostName = "neith-deck";

  gradient.profiles.gaming.enable = true;

  # Enable automatic login for the user.
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = lib.mkDefault "neith";
  services.displayManager.defaultSession = "plasma";
  jovian.decky-loader.user = "neith";

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