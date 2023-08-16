{ lib, pkgs, ... }:

{

  imports = [
    ./secrets
    ./nix.nix
    ./filesystems.nix
    ./syncthing.nix
    ./wireguard.nix
  ];

  networking.hostName = "vera-deck";

  # Enable automatic login for the user.
  #services.xserver.displayManager.autoLogin.enable = true;
  #services.xserver.displayManager.autoLogin.user = lib.mkDefault "vera";
  
  services.xserver.displayManager.defaultSession = "steam-wayland";

  environment.systemPackages = with pkgs; [
    starsector-gamescope-wrap
    space-station-14-launcher
    nix-gaming.osu-stable
    gradient-generator
    prismlauncher
    xivlauncher
  ];
}