 { config, pkgs, ... }:

 {

  imports = [
    ./nix.nix
    ./kernel.nix
    ./programs.nix
    ./wireguard.nix
    ./syncthing.nix
    ./filesystems.nix
    ./secrets/default.nix
    ./libvirtd/default.nix
    ./hardware-configuration.nix
  ];

  networking.hostName = "miracle-crusher";

  gradient.profiles.gaming.enable = true;

  # Enable automatic login for the user.
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "vera";
  services.xserver.displayManager.defaultSession = "plasma";

  # For games and such.
  networking.firewall.allowedTCPPorts = [ 7777 ];
  networking.firewall.allowedUDPPorts = [ 7777 ];

  # WOL support.
  networking.interfaces.enp34s0.wakeOnLan.enable = true;

}
