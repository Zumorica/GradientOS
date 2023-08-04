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
    lilynet = with ips.lilynet; {
      ips = [ "${neith-deck}/32" ];
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
      ];
    };

    slugcatnet = with ips.slugcatnet; {
      ips = [ "${neith-deck}/32" ];
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
      ];
    };
  };

  networking.firewall.trustedInterfaces = [ "lilynet" "slugcatnet" ];
  systemd.network.wait-online.ignoredInterfaces = [ "lilynet" "slugcatnet" ];

  networking.hosts = with ips; {
    "${lilynet.asiyah}" = [ "lilynet" ];
    "${lilynet.miracle-crusher}" = [ "vera" ];
    "${lilynet.vera-deck}" = [ "vera-deck" ];
    "${slugcatnet.asiyah}" = [ "slugcatnet" ];
    "${slugcatnet.remie}" = [ "remie" ];
    "${slugcatnet.miracle-crusher}" = [ "slugcatvera" ];
    "${slugcatnet.luna}" = [ "luna" ];
  };

}