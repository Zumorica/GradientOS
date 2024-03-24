{ config, ... }:
let
  addr = config.gradient.const.wireguard.addresses.gradientnet;
  keys = config.gradient.const.wireguard.pubKeys;
  asiyahPorts = import ./../../hosts/asiyah/misc/service-ports.nix;
in {

  gradient.wireguard.networks.gradientnet.peers = {
    asiyah = {
      ips = [ "${addr.asiyah}/24" "${addr.gradientnet}/24" ];
      listenPort = asiyahPorts.gradientnet;
      publicKey = keys.asiyah;
      privateKeyFile = config.sops.secrets.wireguard-private-key.path;
      endpoint = "vpn.gradient.moe:${toString asiyahPorts.gradientnet}";
      persistentKeepalive = 25;
    };
    briah = {
      ips = [ "${addr.miracle-crusher}/32" ];
      publicKey = keys.miracle-crusher;
      privateKeyFile = config.sops.secrets.wireguard-private-key.path;
    };
    miracle-crusher = {
      ips = [ "${addr.miracle-crusher}/32" ];
      publicKey = keys.miracle-crusher;
      privateKeyFile = config.sops.secrets.wireguard-private-key.path;
    };
    vera-deck = {
      ips = [ "${addr.vera-deck}/32" ];
      publicKey = keys.vera-deck;
      privateKeyFile = config.sops.secrets.wireguard-private-key.path;
    };
    vera-deck-oled = {
      ips = [ "${addr.vera-deck-oled}/32" ];
      publicKey = keys.vera-deck-oled;
      privateKeyFile = config.sops.secrets.wireguard-private-key.path;
    };
    vera-laptop = {
      ips = [ "${addr.vera-laptop}/32" ];
      publicKey = keys.vera-laptop;
    };
    vera-phone = {
      ips = [ "${addr.vera-phone}/32" ];
      publicKey = keys.vera-phone;
    };
  };

}