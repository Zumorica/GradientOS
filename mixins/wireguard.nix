{ config, pkgs, lib, ... }:
let

  addr = config.gradient.const.wireguard.addresses;
  keys = config.gradient.const.wireguard.pubKeys;

  private-key = config.sops.secrets.wireguard-private-key.path;

  asiyahPorts = import ./../hosts/asiyah/misc/service-ports.nix;

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

  asiyahHost = "asiyah";
  briahHost = "briah";
  miracleCrusherHost = "miracle-crusher";
  neithDeckHost = "neith-deck";
  veraDeckHost = "vera-deck";
  veraDeckOledHost = "vera-deck-oled";

  hostName = config.networking.hostName;
  isAsiyah = hostName == asiyahHost;

in
{

  config = lib.mkMerge [

    {
      networking.wireguard.enable = true;
      environment.systemPackages = [ pkgs.wireguard-tools ];
    }

    (lib.mkIf isAsiyah {
      # Enables routing.
      boot.kernel.sysctl = {
        "net.ipv4.conf.all.forwarding" = lib.mkOverride 98 true;
        "net.ipv4.conf.default.forwarding" = lib.mkOverride 98 true;
        "net.ipv6.conf.all.forwarding" = lib.mkOverride 98 true;
        "net.ipv6.conf.default.forwarding" = lib.mkOverride 98 true;
      };

      networking.firewall = {
        allowedTCPPorts = with asiyahPorts; [ gradientnet lilynet slugcatnet ];
        allowedUDPPorts = with asiyahPorts; [ gradientnet lilynet slugcatnet ];
        interfaces.gradientnet.allowedTCPPorts = with asiyahPorts; [ ssh ];
      };
    })

    (lib.mkIf (builtins.any (v: hostName == v) [ asiyahHost briahHost miracleCrusherHost veraDeckHost veraDeckOledHost ]) {
      networking.firewall.trustedInterfaces = lib.mkIf (!isAsiyah) [ "gradientnet" ];
      systemd.network.wait-online.ignoredInterfaces = [ "gradientnet" ];

      networking.wireguard.interfaces.gradientnet = with addr.gradientnet; {
        ips = ["${addr.gradientnet.${hostName}}/${if isAsiyah then "24" else "32"}"];
        listenPort = lib.mkIf isAsiyah asiyahPorts.gradientnet;
        postSetup = lib.mkIf isAsiyah (gen-post-setup "gradientnet" "eno1");
        postShutdown = lib.mkIf isAsiyah (gen-post-shutdown "gradientnet" "eno1");
        privateKeyFile = private-key;
        peers = (if isAsiyah then [
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
          {
            allowedIPs = [ "${vera-laptop}/32" ];
            publicKey = keys.vera-laptop;
          }
          {
            allowedIPs = [ "${vera-deck-oled}/32" ];
            publicKey = keys.vera-deck-oled;
          }
        ] else [
          {
            allowedIPs = [ "${gradientnet}/24" ];
            endpoint = "vpn.gradient.moe:${toString asiyahPorts.gradientnet}";
            publicKey = keys.asiyah;
            persistentKeepalive = 25;
            dynamicEndpointRefreshSeconds = 25;
            dynamicEndpointRefreshRestartSeconds = 10;
          }
          {
            allowedIPs = [ "${gradientnet}/24" ];
            endpoint = "192.168.1.48:${toString asiyahPorts.gradientnet}";
            publicKey = keys.asiyah;
          }
        ]);
      };
    })

    (lib.mkIf (builtins.any (v: hostName == v) [ asiyahHost briahHost miracleCrusherHost neithDeckHost veraDeckHost veraDeckOledHost ]) {
      networking.firewall.trustedInterfaces = lib.mkIf (!isAsiyah) [ "lilynet" "slugcatnet" ];
      systemd.network.wait-online.ignoredInterfaces = [ "lilynet" "slugcatnet" ];

      networking.wireguard.interfaces.lilynet = with addr.lilynet; {
        ips = ["${addr.lilynet.${hostName}}/${if isAsiyah then "24" else "32"}"];
        listenPort = lib.mkIf isAsiyah asiyahPorts.lilynet;
        postSetup = lib.mkIf isAsiyah (gen-post-setup "lilynet" "eno1");
        postShutdown = lib.mkIf isAsiyah (gen-post-shutdown "lilynet" "eno1");
        privateKeyFile = private-key;
        peers = (if isAsiyah then [
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
          {
            allowedIPs = [ "${vera-deck-oled}/32" ];
            publicKey = keys.vera-deck-oled;
          }
        ] else [
          {
            allowedIPs = [ "${slugcatnet}/24" ];
            endpoint = "vpn.gradient.moe:${toString asiyahPorts.slugcatnet}";
            publicKey = keys.asiyah;
            persistentKeepalive = 25;
            dynamicEndpointRefreshSeconds = 25;
            dynamicEndpointRefreshRestartSeconds = 10;
          }
          {
            allowedIPs = [ "${slugcatnet}/24" ];
            endpoint = "192.168.1.48:${toString asiyahPorts.slugcatnet}";
            publicKey = keys.asiyah;
          }
        ]);
      };

      networking.wireguard.interfaces.slugcatnet = with addr.slugcatnet; {
        ips = ["${addr.slugcatnet.${hostName}}/${if isAsiyah then "24" else "32"}"];
        listenPort = lib.mkIf isAsiyah asiyahPorts.slugcatnet;
        postSetup = lib.mkIf isAsiyah (gen-post-setup "slugcatnet" "eno1");
        postShutdown = lib.mkIf isAsiyah (gen-post-shutdown "slugcatnet" "eno1");
        privateKeyFile = private-key;
        peers = (if isAsiyah then [
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
        ] else [
          {
            allowedIPs = [ "${slugcatnet}/24" ];
            endpoint = "vpn.gradient.moe:${toString asiyahPorts.slugcatnet}";
            publicKey = keys.asiyah;
            persistentKeepalive = 25;
            dynamicEndpointRefreshSeconds = 25;
            dynamicEndpointRefreshRestartSeconds = 10;
          }
          {
            allowedIPs = [ "${slugcatnet}/24" ];
            endpoint = "192.168.1.48:${toString asiyahPorts.slugcatnet}";
            publicKey = keys.asiyah;
          }
        ]);
      };
    })

  ];

}