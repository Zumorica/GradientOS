{ pkgs, lib, ... }:

{

  imports = [
    ./nix.nix
    ./programs.nix
    ./syncthing.nix
    ./wireguard.nix
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

}