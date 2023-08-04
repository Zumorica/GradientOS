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
  
  services.jackett = {
    inherit group;
    enable = true;
  };

  services.bazarr = {
    inherit group;
    enable = true;
    listenPort = ports.bazarr;
  };

  services.deluge = {
    inherit group;
    enable = true;
    web.enable = true;
  };

  networking.firewall.allowedUDPPorts = [ ports.jellyfin-client-discovery ];

  users.groups.${group} = {};
}