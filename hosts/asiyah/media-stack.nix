{ config, ... }:
let
  ports = import ./misc/service-ports.nix;
  group = "media-stack";
in {

  services.jellyfin = {
    inherit group;
    enable = true;
  };

  services.radarr = {
    inherit group;
    enable = true;
  };

  services.sonarr = {
    inherit group;
    enable = true;
    openFirewall = true;
  };
  
  services.jackett = {
    inherit group;
    enable = true;
  };

  services.bazarr = {
    inherit group;
    enable = true;
    listenPort = ports.bazarr;
  };

  services.transmission = {
    inherit group;
    enable = true;
    openRPCPort = true;
    openPeerPorts = true;
    settings = {
      rpc-port = ports.transmission;
      peer-port = ports.transmission-peer;
    };
  };

  networking.firewall.allowedUDPPorts = [ ports.jellyfin-client-discovery ];

  users.groups.${group}.members = with config.services; [
    jellyfin.user
    radarr.user
    sonarr.user
    jackett.user
    bazarr.user
    transmission.user
  ];
}