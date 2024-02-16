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

  # Use Jovian's steam deck UI autostart.
  services.xserver.displayManager.sddm.enable = lib.mkForce false;
  jovian.steam.autoStart = true;
  jovian.steam.user = "vera";
  jovian.decky-loader.user = "vera";
  jovian.steam.desktopSession = "plasma";
  
  # Broken on latest unstable... TODO: Check if fixed? Then again, I don't really use this...
  # services.xserver.desktopManager.plasma5.mobile.enable = true;

}