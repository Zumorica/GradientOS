{ lib, pkgs, ... }:

{

  imports = [
    ./nix.nix
    ./kernel.nix
    ./programs.nix
    ./syncthing.nix
    ./wireguard.nix
    ./filesystems.nix
    ./secrets/default.nix
  ];

  networking.hostName = "vera-deck";

  gradient.profiles.gaming.enable = true;

  # Use Jovian's steam deck UI autostart.
  services.xserver.displayManager.sddm.enable = lib.mkForce false;
  jovian.steam.autoStart = true;
  jovian.steam.user = "vera";
  jovian.decky-loader.user = "vera";
  jovian.steam.desktopSession = "plasma";

}