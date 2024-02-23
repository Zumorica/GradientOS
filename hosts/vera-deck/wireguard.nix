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
      ips = [ "${vera-deck}/32" ];
      privateKeyFile = private-key;
      peers = [
        # Gradient
        {
          allowedIPs = [ "${gradientnet}/24" ];
          endpoint = "vpn.gradient.moe:${toString asiyah-ports.gradientnet}";
          publicKey = keys.asiyah;
          persistentKeepalive = 25;
          dynamicEndpointRefreshSeconds = 25;
          dynamicEndpointRefreshRestartSeconds = 10;
        }

        # Gradient, but local net
        {
          allowedIPs = [ "${gradientnet}/24" ];
          endpoint = "192.168.1.48:${toString asiyah-ports.gradientnet}";
          publicKey = keys.asiyah;
        }
      ];
    };

    lilynet = with ips.lilynet; {
      ips = [ "${vera-deck}/32" ];
      privateKeyFile = private-key;
      peers = [
        # Gradient
        {
          allowedIPs = [ "${lilynet}/24" ];
          endpoint = "vpn.gradient.moe:${toString asiyah-ports.lilynet}";
          publicKey = keys.asiyah;
          persistentKeepalive = 25;
          dynamicEndpointRefreshSeconds = 25;
          dynamicEndpointRefreshRestartSeconds = 10;
        }

        # Gradient, but local net
        {
          allowedIPs = [ "${lilynet}/24" ];
          endpoint = "192.168.1.48:${toString asiyah-ports.lilynet}";
          publicKey = keys.asiyah;
        }
      ];
    };
  };

  networking.firewall.trustedInterfaces = [ "gradientnet" "lilynet" ];
  systemd.network.wait-online.ignoredInterfaces = [ "gradientnet" "lilynet" ];

  networking.hosts = with ips; {
    "${gradientnet.asiyah}" = [ "gradientnet" "gradient" "asiyah" ];
    "${gradientnet.briah}"  = [ "briah" ];
    "${gradientnet.miracle-crusher}" = [ "vera" ];
    "${gradientnet.vera-deck-oled}" = [ "deck-oled" ];
    "${gradientnet.vera-laptop}" = [ "laptop" ];
    "${lilynet.asiyah}" = [ "lilynet" ];
    "${lilynet.neith-deck}" = [ "neith" "lily" ];
  };

}