{ lib, pkgs, ... }:

{

  imports = [
    ./nix.nix
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
  jovian.steam.desktopSession = "plasma";
  
  services.xserver.desktopManager.plasma5.mobile.enable = true;

  environment.systemPackages = with pkgs; [
    starsector-gamescope-wrap
    space-station-14-launcher
    nix-gaming.osu-stable
    gradient-generator
    prismlauncher
    xivlauncher
  ];
}