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
  networking.firewall.allowedTCPPortRanges = [ { from=7777; to=7787; } ];
  networking.firewall.allowedUDPPortRanges = [ { from=7777; to=7787; } ];

  # WOL support.
  networking.interfaces.enp16s0.wakeOnLan.enable = true;

}
