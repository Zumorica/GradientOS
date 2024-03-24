/**
  TODO: Explain
*/
{ config, lib, pkgs, ... }:
let
  cfg = config.gradient;
in
{

  options = {
    gradient.wireguard.hostName = lib.mkOption {
      type = lib.types.str;
      default = config.networking.hostName;
    };
    gradient.wireguard.networks = lib.mkOption {
      description = "Wireguard networks to generate configurations for.";
      default = {};
      type = lib.types.attrsOf lib.types.submodule ({ ... }: {
        options = {
          peers = lib.mkOption { 
            description = "Peers that belong to the network.";
            default = {};
            type = lib.types.attrsOf lib.types.submodule ({ ... }: {
              options = {
                ips = lib.mkOption {
                  type = lib.types.listOf lib.types.str;
                };

                endpoint = lib.mkOption {
                  type = lib.types.nullOr lib.types.str;
                  default = null;
                };

                listenPort = lib.mkOption {
                  type = lib.types.nullOr lib.types.int;
                  default = null;
                };

                publicKey = lib.mkOptions {
                  type = lib.types.singleLineStr;
                };

                privateKeyFile = lib.mkOptions {
                  type = lib.types.nullOr lib.types.str;
                };

                routingInterface = lib.mkOption {
                  type = lib.types.nullOr lib.types.str;
                  default = null;
                };

                persistentKeepalive = lib.mkOption {
                  type = lib.types.nullOr lib.types.ints.unsigned;
                  default = null;
                };
              };
            });
          };
        };  
      });
    };
  };

  config = 
    let
      currentMachineInNetwork = network: builtins.hasAttr cfg.wireguard.hostName network.peers;
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
    in
    lib.mkMerge
      (lib.attrsets.mapAttrsToList 
        (networkName: network: 
          lib.mkIf (currentMachineInNetwork network) 
            (let
              currentPeer = network.peers.${cfg.wireguard.hostName};
              currentPeerHasEndpoint = currentPeer.endpoint != null;
              otherPeers = lib.attrsets.filterAttrs 
                (name: _: name != cfg.wireguard.hostName) 
                network.peers;
              otherPeersWithEndpoints = lib.attrsets.filterAttrs
                (_: peer: peer.endpoint != null)
                otherPeers;
            in
            {
              networking.wireguard.interfaces.${networkName} = {
                inherit (currentPeer) ips privateKeyFile;
                peers = lib.attrsets.mapAttrs 
                  (peerName: peer: {
                    inherit (peer) publicKey;
                    allowedIPs = peer.ips;
                    endpoint = peer.endpoint + ":${peer.listenPort}";
                  } 
                  //
                  (if peer.persistentKeepalive != null then {
                    inherit (peer) persistentKeepalive;
                    dynamicEndpointRefreshSeconds = peer.persistentKeepalive;
                    dynamicEndpointRefreshRestartSeconds = peer.persistentKeepalive / 2;
                  } else {}))
                  (if currentPeerHasEndpoint then otherPeers else otherPeersWithEndpoints);
              }
              //
              (if currentPeer.routingInterface != null then {
                postSetup = gen-post-setup networkName currentPeer.routingInterface;
                postShutdown = gen-post-shutdown networkName currentPeer.routingInterface;
              } else {});
            })
        )
        cfg.wireguard.networks);

}