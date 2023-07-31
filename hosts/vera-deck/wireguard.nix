{ config, pkgs, ... }:

let
  ips = import ../../misc/wireguard-addresses.nix;
  keys = import ../../misc/wireguard-pub-keys.nix;
  briah-ports = import ../briah/misc/service-ports.nix;
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
          endpoint = "vpn.gradient.moe:${toString briah-ports.gradientnet}";
          publicKey = keys.briah;
          persistentKeepalive = 25;
          dynamicEndpointRefreshSeconds = 25;
          dynamicEndpointRefreshRestartSeconds = 10;
        }

        # Gradient, but local net
        {
          allowedIPs = [ "${gradientnet}/24" ];
          endpoint = "192.168.1.24:${toString briah-ports.gradientnet}";
          publicKey = keys.briah;
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
          endpoint = "vpn.gradient.moe:${toString briah-ports.lilynet}";
          publicKey = keys.briah;
          persistentKeepalive = 25;
          dynamicEndpointRefreshSeconds = 25;
          dynamicEndpointRefreshRestartSeconds = 10;
        }

        # Gradient, but local net
        {
          allowedIPs = [ "${lilynet}/24" ];
          endpoint = "192.168.1.24:${toString briah-ports.lilynet}";
          publicKey = keys.briah;
        }
      ];
    };
  };

  networking.firewall.trustedInterfaces = [ "gradientnet" "lilynet" ];
  systemd.network.wait-online.ignoredInterfaces = [ "gradientnet" "lilynet" ];

  networking.hosts = with ips; {
    "${gradientnet.briah}"  = [ "gradient" "briah" ];
    "${gradientnet.miracle-crusher}" = [ "vera" ];
    "${lilynet.briah}" = [ "lilynet" ];
    "${lilynet.neith-deck}" = [ "neith" "lily" ];
  };

}