 { config, ... }:

 {

  imports = [
    ./backups.nix
    ./programs.nix
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
  networking.firewall.allowedTCPPortRanges = [ { from=7777; to=7787; } { from=25565; to=25566; } ];
  networking.firewall.allowedUDPPortRanges = [ { from=7777; to=7787; } { from=25565; to=25566; } ];

  # WOL support.
  networking.interfaces.enp16s0.wakeOnLan.enable = true;

  gradient.substituters = {
    asiyah = "ssh-ng://nix-ssh@asiyah.gradient?priority=40";
    briah = "ssh-ng://nix-ssh@briah.gradient?priority=60";
    vera-deck = "ssh-ng://nix-ssh@vera-deck.gradient?priority=45";
    vera-deck-oled = "ssh-ng://nix-ssh@vera-deck-oled.gradient?priority=50";
    neith-deck = "ssh-ng://nix-ssh@neith-deck.lily?priority=100";
  };

  # Share QL-600 printer!
  services.printing = {
    openFirewall = true;
    defaultShared = true;
    browsing = true;
  };

  networking.hosts = with config.gradient.const.wireguard.addresses; {
    "${gradientnet.asiyah}"  = [ "gradientnet" "gradient" "asiyah" ];
    "${gradientnet.briah}" = [ "briah" ];
    "${gradientnet.vera-deck}" = [ "deck" ];
    "${gradientnet.vera-deck-oled}" = [ "deck-oled" ];
    "${gradientnet.vera-laptop}" = [ "laptop" ];
    "${lilynet.asiyah}" = [ "lilynet" ];
    "${lilynet.neith-deck}" = [ "neith-deck" ];
    "${slugcatnet.asiyah}" = [ "slugcatnet" ];
    "${slugcatnet.remie}" = [ "remie" ];
    "${slugcatnet.luna}" = [ "luna" ];
  };

}
