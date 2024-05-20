{ ... }:
let
  ports = import ./misc/service-ports.nix;
  addresses = import ../../misc/wireguard-addresses.nix;
in {

  services.mainsail = {
    enable = true;
    nginx.listen = [
      {
        addr = "127.0.0.1";
        port = ports.mainsail;
      }
      {
        addr = addresses.gradientnet.vera-deck;
        port = ports.mainsail;
      }
      {
        addr = addresses.lilynet.vera-deck;
        port = ports.mainsail;
      }
    ];
    nginx.serverAliases = [
      "vera-deck.gradient"
      "vera-deck.lily"
    ];
  };

  # Increase max upload size for uploading gcode files from PrusaSlicer
  services.nginx.clientMaxBodySize = "1000m";

  networking.firewall.interfaces.gradientnet.allowedTCPPorts = [ ports.mainsail ];
  networking.firewall.interfaces.gradientnet.allowedUDPPorts = [ ports.mainsail ];

  networking.firewall.interfaces.lilynet.allowedTCPPorts = [ ports.mainsail ];
  networking.firewall.interfaces.lilynet.allowedUDPPorts = [ ports.mainsail ];

}