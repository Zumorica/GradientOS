{ config, ... }:
let
  addresses = config.gradient.const.wireguard.addresses;
  ports = import ./misc/service-ports.nix;
  generate-container = interface: listen-address: port: addresses: {
    autoStart = true;
    ephemeral = true;
    config = {
      services.dnsmasq = {
        enable = true;
        alwaysKeepRunning = true;
        settings = {
          inherit interface port;
          listen-address = "::1,127.0.0.1,${listen-address}";
          address = addresses;
        };  
      };
    };
  };
in
{

  containers.dns-lan = generate-container "eno1" "192.168.1.24" ports.dns-lan [
    # TODO
  ];
  networking.firewall.interfaces.eno1.allowedTCPPorts = [ ports.dns-lan ];

  containers.dns-gradientnet = with addresses.gradientnet; generate-container "gradientnet" asiyah ports.dns-gradientnet [
    "/asiyah.gradient/${asiyah}"
    "/briah.gradient/${briah}"
    "/vera.gradient/${miracle-crusher}"
    "/vera-deck.gradient/${vera-deck}"
    "/vera-deck-oled.gradient/${vera-deck-oled}"
    "/vera-phone.gradient/${vera-phone}"
    "/vera-laptop.gradient/${vera-laptop}"
  ];
  networking.firewall.interfaces.gradientnet.allowedTCPPorts = [ ports.dns-gradientnet ];
  networking.firewall.interfaces.gradientnet.allowedUDPPorts = [ ports.dns-gradientnet ];

  containers.dns-lilynet = with addresses.lilynet; generate-container "lilynet" asiyah ports.dns-lilynet [
    "/asiyah.lily/${asiyah}"
    "/briah.lily/${briah}"
    "/vera.lily/${miracle-crusher}"
    "/vera-deck.lily/${vera-deck}"
    "/vera-deck-oled.lily/${vera-deck-oled}"
    "/neith-deck.lily/${neith-deck}"
  ];
  networking.firewall.interfaces.lilynet.allowedTCPPorts = [ ports.dns-lilynet ];
  networking.firewall.interfaces.lilynet.allowedUDPPorts = [ ports.dns-lilynet ];

  containers.dns-slugcatnet = with addresses.slugcatnet; generate-container "slugcatnet" asiyah ports.dns-slugcatnet [
    "/asiyah.slugcat/${asiyah}"
    "/briah.slugcat/${briah}"
    "/remie.slugcat/${remie}"
    "/vera.slugcat/${miracle-crusher}"
    "/neith-deck.slugcat/${neith-deck}"
    "/luna.slugcat/${luna}"
  ];
  networking.firewall.interfaces.slugcatnet.allowedTCPPorts = [ ports.dns-slugcatnet ];
  networking.firewall.interfaces.slugcatnet.allowedUDPPorts = [ ports.dns-slugcatnet ];

}