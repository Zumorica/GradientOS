{ config, pkgs, ... }:

let
  private-key = config.sops.secrets.wireguard-private-key.path;
in {

  networking.wireguard.enable = true;
  environment.systemPackages = [ pkgs.wireguard-tools ];

  networking.wg-quick.interfaces = {
    gradientnet = {
      address = [ "192.168.24.2/32" ];
      listenPort = 51820;
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
      address = [ "192.168.109.2/32" ];
      listenPort = 51821;
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

    slugcatnet = {
      address = [ "192.168.4.3/32" ];
      listenPort = 51822;
      privateKeyFile = private-key;
      peers = [
        # Gradient
        {
          allowedIPs = [ "192.168.4.0/24" ];
          endpoint = "vpn.zumorica.es:1196";
          publicKey = "oIa6pYWG0rIZ0lYiLlOCiR74FSoXkQOfLHssz3iB/Rc=";
          persistentKeepalive = 25;
        }

        # Gradient but local net
        {
          allowedIPs = [ "192.168.4.0/24" ];
          endpoint = "192.168.1.24:1196";
          publicKey = "oIa6pYWG0rIZ0lYiLlOCiR74FSoXkQOfLHssz3iB/Rc=";
        }
      ];
    };
  };

  networking.firewall.trustedInterfaces = [ "gradientnet" "lilynet" "slugcatnet" ];
  systemd.network.wait-online.ignoredInterfaces = [ "gradientnet" "lilynet" "slugcatnet" ];

  networking.hosts = {
    "192.168.24.1"  = ["gradient"];
    "192.168.24.5" = [ "deck" ];
    "192.168.109.1" = ["lilynet"];
    "192.168.109.5" = ["neith" "lily"];
    "192.168.4.1" = [ "slugcatnet" ];
    "192.168.4.2" = [ "remie" ];
    "192.168.4.4" = [ "luna" ];
  };

}