{ config, pkgs, ... }:

let
  private-key = config.sops.secrets.wireguard-private-key.path;
in {

  networking.wireguard.enable = true;
  environment.systemPackages = [ pkgs.wireguard-tools ];

  networking.wg-quick.interfaces = {

    lilynet = {
      address = [ "192.168.109.5/32" ];
      privateKeyFile = private-key;
      peers = [
        # Gradient
        {
          allowedIPs = [ "192.168.109.0/24" ];
          endpoint = "vpn.zumorica.es:1195";
          publicKey = "oIa6pYWG0rIZ0lYiLlOCiR74FSoXkQOfLHssz3iB/Rc=";
          persistentKeepalive = 25;
        }
      ];
    };

    slugcatnet = {
      address = [ "192.168.4.5/32" ];
      privateKeyFile = private-key;
      peers = [
        # Gradient
        {
          allowedIPs = [ "192.168.4.0/24" ];
          endpoint = "vpn.zumorica.es:1196";
          publicKey = "oIa6pYWG0rIZ0lYiLlOCiR74FSoXkQOfLHssz3iB/Rc=";
          persistentKeepalive = 25;
        }
      ];
    };
    
  };

  networking.firewall.trustedInterfaces = [ "lilynet" "slugcatnet" ];
  systemd.network.wait-online.ignoredInterfaces = [ "lilynet" "slugcatnet" ];

  networking.hosts = {
    "192.168.109.1" = [ "lilynet" ];
    "192.168.109.2" = [ "vera" ];
    "192.168.4.1" = [ "slugcatnet" ];
    "192.168.4.2" = [ "remie" ];
    "192.168.4.3" = [ "slugcatvera" ];
    "192.168.4.4" = [ "luna" ];
  };

}