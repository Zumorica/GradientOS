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
        addr = addresses.gradientnet.briah;
        port = ports.mainsail;
      }
    ];
  };

  # Increase max upload size for uploading gcode files from PrusaSlicer
  services.nginx.clientMaxBodySize = "1000m";

  networking.firewall.interfaces.gradientnet.allowedTCPPorts = [ ports.mainsail ];
  networking.firewall.interfaces.gradientnet.allowedUDPPorts = [ ports.mainsail ];

}