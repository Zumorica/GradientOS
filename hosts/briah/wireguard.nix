{ config, pkgs, ... }:

let
  ips = import ../../misc/wireguard-addresses.nix;
  keys = import ../../misc/wireguard-pub-keys.nix;
  asiyah-ports = import ../../hosts/asiyah/misc/service-ports.nix;
  private-key = config.sops.secrets.wireguard-private-key.path;
  ports = import ./misc/service-ports.nix;
in {
  networking.wireguard.enable = true;
  environment.systemPackages = [ pkgs.wireguard-tools ];

  networking.wireguard.interfaces = {
    gradientnet = with ips.gradientnet; {
      ips = [ "${briah}/32" ];
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
      ips = [ "${briah}/32" ];
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
      ips = [ "${briah}/32" ];
      privateKeyFile = private-key;
      peers = [
        {
          allowedIPs = [ "${asiyah}/24" ];
          publicKey = keys.asiyah;
        }
      ];
    };
  };

  networking.firewall.interfaces.gradientnet.allowedTCPPorts = with ports; [ ssh ];
  systemd.network.wait-online.ignoredInterfaces = [ "gradientnet" "lilynet" "slugcatnet" ];

  networking.hosts = with ips; {
    "${gradientnet.asiyah}" = [ "asiyah" ];
    "${gradientnet.miracle-crusher}" = [ "vera" ];
    "${gradientnet.vera-deck}" = [ "deck" ];
    "${lilynet.neith-deck}" = [ "lily" "neith" ];
  };
}