{ config, pkgs, ... }:

let
  ips = import ../../misc/wireguard-addresses.nix;
  keys = import ../../misc/wireguard-pub-keys.nix;
  private-key = config.sops.secrets.wireguard-private-key.path;
in {

  networking.wireguard.enable = true;
  environment.systemPackages = [ pkgs.wireguard-tools ];

  networking.wireguard.interfaces = {
    gradientnet = with ips.gradientnet; {
      ips = [ "${miracle-crusher}/32" ];
      privateKeyFile = private-key;
      peers = [
        {
          allowedIPs = [ "${gradientnet}/24" ];
          endpoint = "vpn.zumorica.es:1194";
          publicKey = keys.briah;
          persistentKeepalive = 25;
          dynamicEndpointRefreshSeconds = 25;
          dynamicEndpointRefreshRestartSeconds = 10;
        }
        {
          allowedIPs = [ "${gradientnet}/24" ];
          endpoint = "192.168.1.24:1194";
          publicKey = keys.briah;
        }
      ];
    };

    lilynet = with ips.lilynet; {
      ips = [ "${miracle-crusher}/32" ];
      privateKeyFile = private-key;
      peers = [
        {
          allowedIPs = [ "${lilynet}/24" ];
          endpoint = "vpn.zumorica.es:1195";
          publicKey = keys.briah;
          persistentKeepalive = 25;
          dynamicEndpointRefreshSeconds = 25;
          dynamicEndpointRefreshRestartSeconds = 10;
        }
        {
          allowedIPs = [ "${lilynet}/24" ];
          endpoint = "192.168.1.24:1195";
          publicKey = keys.briah;
        }
      ];
    };

    slugcatnet = with ips.slugcatnet; {
      ips = [ "${miracle-crusher}/32" ];
      privateKeyFile = private-key;
      peers = [
        {
          allowedIPs = [ "${slugcatnet}/24" ];
          endpoint = "vpn.zumorica.es:1196";
          publicKey = keys.briah;
          persistentKeepalive = 25;
        }
        {
          allowedIPs = [ "${slugcatnet}/24" ];
          endpoint = "192.168.1.24:1196";
          publicKey = keys.briah;
        }
      ];
    };
  };

  networking.firewall.trustedInterfaces = [ "gradientnet" "lilynet" "slugcatnet" ];
  systemd.network.wait-online.ignoredInterfaces = [ "gradientnet" "lilynet" "slugcatnet" ];

  networking.hosts = with ips; {
    "${gradientnet.briah}"  = [ "gradient" "briah" ];
    "${gradientnet.vera-deck}" = [ "deck" ];
    "${lilynet.briah}" = [ "lilynet" ];
    "${lilynet.neith-deck}" = [ "neith" "lily" ];
    "${slugcatnet.briah}" = [ "slugcatnet" ];
    "${slugcatnet.remie}" = [ "remie" ];
    "${slugcatnet.luna}" = [ "luna" ];
  };

}