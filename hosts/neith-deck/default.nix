{ pkgs, lib, ... }:

{

  imports = [
    ./nix.nix
    ./programs.nix
    ./syncthing.nix
    ./wireguard.nix
    ./filesystems.nix
    ./secrets/default.nix
  ];

  networking.hostName = "neith-deck";

  # Enable automatic login for the user.
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = lib.mkDefault "neith";
  jovian.decky-loader.user = "neith";

}