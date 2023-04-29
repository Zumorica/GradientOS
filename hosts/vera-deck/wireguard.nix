{ config, pkgs, ... }:

let
  private-key = config.sops.secrets.wireguard-private-key.path;
in {

  networking.wireguard.enable = true;
  environment.systemPackages = [ pkgs.wireguard-tools ];

  networking.wg-quick.interfaces = {
    gradientnet = {
      address = [ "192.168.24.5/32" ];
      privateKeyFile = private-key;
      peers = [
        # Gradient
        {
          allowedIPs = [ "192.168.24.0/24" ];
          endpoint = "vpn.zumorica.es:1194";
          publicKey = "oIa6pYWG0rIZ0lYiLlOCiR74FSoXkQOfLHssz3iB/Rc=";
          persistentKeepalive = 25;
        }

        # Gradient, but local net
        {
          allowedIPs = [ "192.168.24.0/24" ];
          endpoint = "192.168.1.24:1194";
          publicKey = "oIa6pYWG0rIZ0lYiLlOCiR74FSoXkQOfLHssz3iB/Rc=";
        }
      ];
    };

    lilynet = {
      address = [ "192.168.109.4/32" ];
      privateKeyFile = private-key;
      peers = [
        # Gradient
        {
          allowedIPs = [ "192.168.109.0/24" ];
          endpoint = "vpn.zumorica.es:1195";
          publicKey = "oIa6pYWG0rIZ0lYiLlOCiR74FSoXkQOfLHssz3iB/Rc=";
          persistentKeepalive = 25;
        }

        # Gradient, but local net
        {
          allowedIPs = [ "192.168.109.0/24" ];
          endpoint = "192.168.1.24:1195";
          publicKey = "oIa6pYWG0rIZ0lYiLlOCiR74FSoXkQOfLHssz3iB/Rc=";
        }
      ];
    };
  };

  networking.firewall.trustedInterfaces = [ "gradientnet" "lilynet" ];
  systemd.network.wait-online.ignoredInterfaces = [ "gradientnet" "lilynet" ];

  networking.hosts = {
    "192.168.24.1"  = ["gradient"];
    "192.168.24.2" = [ "vera" ];
    "192.168.109.1" = ["lilynet"];
    "192.168.109.5" = ["neith" "lily"];
  };

}