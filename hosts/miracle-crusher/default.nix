 { ... }:

 {

  imports = [
    ./nix.nix
    ./backups.nix
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
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "vera";
  services.displayManager.defaultSession = "plasma";

  services.hardware.openrgb.enable = true;

  # For games and such.
  networking.firewall.allowedTCPPorts = [ 7777 ];
  networking.firewall.allowedUDPPorts = [ 7777 ];

  # WOL support.
  networking.interfaces.enp16s0.wakeOnLan.enable = true;

}
