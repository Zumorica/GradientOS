{ config, pkgs, ... }:

let
  ips = import ../../misc/wireguard-addresses.nix;
  keys = import ../../misc/wireguard-pub-keys.nix;
  asiyah-ports = import ../asiyah/misc/service-ports.nix;
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
          endpoint = "vpn.gradient.moe:${toString asiyah-ports.gradientnet}";
          publicKey = keys.asiyah;
          persistentKeepalive = 25;
          dynamicEndpointRefreshSeconds = 25;
          dynamicEndpointRefreshRestartSeconds = 10;
        }
        {
          allowedIPs = [ "${gradientnet}/24" ];
          endpoint = "192.168.1.48:${toString asiyah-ports.gradientnet}";
          publicKey = keys.asiyah;
        }
      ];
    };

    lilynet = with ips.lilynet; {
      ips = [ "${miracle-crusher}/32" ];
      privateKeyFile = private-key;
      peers = [
        {
          allowedIPs = [ "${lilynet}/24" ];
          endpoint = "vpn.gradient.moe:${toString asiyah-ports.lilynet}";
          publicKey = keys.asiyah;
          persistentKeepalive = 25;
          dynamicEndpointRefreshSeconds = 25;
          dynamicEndpointRefreshRestartSeconds = 10;
        }
        {
          allowedIPs = [ "${lilynet}/24" ];
          endpoint = "192.168.1.48:${toString asiyah-ports.lilynet}";
          publicKey = keys.asiyah;
        }
      ];
    };

    slugcatnet = with ips.slugcatnet; {
      ips = [ "${miracle-crusher}/32" ];
      privateKeyFile = private-key;
      peers = [
        {
          allowedIPs = [ "${slugcatnet}/24" ];
          endpoint = "vpn.gradient.moe:${toString asiyah-ports.slugcatnet}";
          publicKey = keys.asiyah;
          persistentKeepalive = 25;
          dynamicEndpointRefreshSeconds = 25;
          dynamicEndpointRefreshRestartSeconds = 10;
        }
        {
          allowedIPs = [ "${slugcatnet}/24" ];
          endpoint = "192.168.1.48:${toString asiyah-ports.slugcatnet}";
          publicKey = keys.asiyah;
        }
      ];
    };
  };

  networking.firewall.trustedInterfaces = [ "gradientnet" "lilynet" "slugcatnet" ];
  systemd.network.wait-online.ignoredInterfaces = [ "gradientnet" "lilynet" "slugcatnet" ];

  networking.hosts = with ips; {
    "${gradientnet.asiyah}"  = [ "gradientnet" "gradient" "asiyah" ];
    "${gradientnet.briah}" = [ "briah" ];
    "${gradientnet.vera-deck}" = [ "deck" ];
    "${gradientnet.vera-deck-oled}" = [ "deck-oled" ];
    "${gradientnet.vera-laptop}" = [ "laptop" ];
    "${lilynet.asiyah}" = [ "lilynet" ];
    "${lilynet.neith-deck}" = [ "neith" "lily" ];
    "${slugcatnet.asiyah}" = [ "slugcatnet" ];
    "${slugcatnet.remie}" = [ "remie" ];
    "${slugcatnet.luna}" = [ "luna" ];
  };

}