{ config, pkgs, lib, ... }:

let
  ports = import misc/service-ports.nix;
  ips = import ../../misc/wireguard-addresses.nix;
  keys = import ../../misc/wireguard-pub-keys.nix;
  private-key = config.sops.secrets.wireguard-private-key.path;
  iptablesCmd = "${pkgs.iptables}/bin/iptables";
  ip6tablesCmd = "${pkgs.iptables}/bin/ip6tables";
  gen-post-setup = vpn: interface: 
  "
    ${iptablesCmd} -A FORWARD -i ${vpn} -j ACCEPT;
    ${iptablesCmd} -t nat -A POSTROUTING -o ${interface} -j MASQUERADE;
    ${ip6tablesCmd} -A FORWARD -i ${vpn} -j ACCEPT;
    ${ip6tablesCmd} -t nat -A POSTROUTING -o ${interface} -j MASQUERADE
  ";
  gen-post-shutdown = vpn: interface:
  "
    ${iptablesCmd} -D FORWARD -i ${vpn} -j ACCEPT;
    ${iptablesCmd} -t nat -D POSTROUTING -o ${interface} -j MASQUERADE;
    ${ip6tablesCmd} -D FORWARD -i ${vpn} -j ACCEPT;
    ${ip6tablesCmd} -t nat -D POSTROUTING -o ${interface} -j MASQUERADE
  ";
in {
  networking.wireguard.enable = true;
  environment.systemPackages = [ pkgs.wireguard-tools ];

  # Enables routing.
  boot.kernel.sysctl = {
    "net.ipv4.conf.all.forwarding" = lib.mkOverride 98 true;
    "net.ipv4.conf.default.forwarding" = lib.mkOverride 98 true;
    "net.ipv6.conf.all.forwarding" = lib.mkOverride 98 true;
    "net.ipv6.conf.default.forwarding" = lib.mkOverride 98 true;
  };

  networking.wireguard.interfaces = {
    gradientnet = with ips.gradientnet; {
      ips = [ "${asiyah}/24" ];
      listenPort = ports.gradientnet;
      privateKeyFile = private-key;
      postSetup = gen-post-setup "gradientnet" "end0";
      postShutdown = gen-post-shutdown "gradientnet" "end0";
      peers = [
        {
          allowedIPs = [ "${briah}/32" ];
          publicKey = keys.briah;
        }
        {
          allowedIPs = [ "${miracle-crusher}/32" ];
          publicKey = keys.miracle-crusher;
        }
        {
          allowedIPs = [ "${vera-deck}/32" ];
          publicKey = keys.vera-deck;
        }
        {
          allowedIPs = [ "${vera-phone}/32" ];
          publicKey = keys.vera-phone;
        }
      ];
    };

    lilynet = with ips.lilynet; {
      ips = [ "${asiyah}/24" ];
      listenPort = ports.lilynet;
      privateKeyFile = private-key;
      postSetup = gen-post-setup "lilynet" "end0";
      postShutdown = gen-post-shutdown "lilynet" "end0";
      peers = [
        {
          allowedIPs = [ "${briah}/32" ];
          publicKey = keys.briah;
        }
        {
          allowedIPs = [ "${miracle-crusher}/32" ];
          publicKey = keys.miracle-crusher;
        }
        {
          allowedIPs = [ "${neith-deck}/32" ];
          publicKey = keys.neith-deck;
        }
        {
          allowedIPs = [ "${vera-deck}/32" ];
          publicKey = keys.vera-deck;
        }
      ];
    };

    slugcatnet = with ips.slugcatnet; {
      ips = [ "${asiyah}/24" ];
      listenPort = ports.slugcatnet;
      privateKeyFile = private-key;
      postSetup = gen-post-setup "slugcatnet" "end0";
      postShutdown = gen-post-shutdown "slugcatnet" "end0";
      peers = [
        {
          allowedIPs = [ "${briah}/32" ];
          publicKey = keys.briah;
        }
        {
          allowedIPs = [ "${remie}/32" ];
          publicKey = keys.remie;
        }
        {
          allowedIPs = [ "${miracle-crusher}/32" ];
          publicKey = keys.miracle-crusher;
        }
        {
          allowedIPs = [ "${luna}/32" ];
          publicKey = keys.luna;
        }
        {
          allowedIPs = [ "${neith-deck}/32" ];
          publicKey = keys.neith-deck;
        }
      ];
    };
  };

  networking.firewall = {
    allowedTCPPorts = with ports; [ gradientnet lilynet slugcatnet ];
    allowedUDPPorts = with ports; [ gradientnet lilynet slugcatnet ];
    trustedInterfaces = [ "gradientnet" "lilynet" "slugcatnet" ];
  };

  systemd.network.wait-online.ignoredInterfaces = [ "gradientnet" "lilynet" "slugcatnet" ];

  networking.hosts = with ips; {
    "${gradientnet.briah}" = [ "briah" ];
    "${gradientnet.miracle-crusher}" = [ "vera" ];
    "${gradientnet.vera-deck}" = [ "deck" ];
    "${lilynet.neith-deck}" = [ "lily" "neith" ];
  };
}