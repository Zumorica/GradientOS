/*

  Public gradient.moe website.

*/
{ self, pkgs, config, ... }:
let
  ports = import ../../briah/misc/service-ports.nix;
in
{

  services.nginx.virtualHosts."gradient.moe" = {
    root = toString self.inputs.gradient-moe.packages.${pkgs.system}.default;
    default = true;
    enableACME = true;
    addSSL = true;
    serverAliases = [
      "www.gradient.moe"
      "zumorica.es"
      "www.zumorica.es"
    ];
    locations."/daily_gradient/data/" = {
      alias = "/data/gradient-data/";
    };
  };

  services.nginx.virtualHosts."hass.gradient.moe" = {
    enableACME = true;
    addSSL = true;
    locations."/".extraConfig = ''
      proxy_pass http://${config.gradient.const.wireguard.addresses.gradientnet.briah}:${toString ports.home-assistant};
      proxy_set_header Host $host;
      proxy_redirect http:// https://;
      proxy_http_version 1.1;
      proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
      proxy_set_header Upgrade $http_upgrade;
      proxy_set_header Connection $connection_upgrade;
    '';
  };

}