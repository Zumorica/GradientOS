{ pkgs, lib, ... }:

{

  imports = [
    ./secrets
    ./nix.nix
    ./filesystems.nix
    ./syncthing.nix
    ./wireguard.nix
  ];

  networking.hostName = "neith-deck";

  # Enable automatic login for the user.
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = lib.mkDefault "neith";
  
  programs.steam.package = pkgs.steam-original-fixed;
  environment.systemPackages = with pkgs; [
    starsector-gamescope-wrap
    steam-deck-client
    prismlauncher
    xivlauncher
  ];

}