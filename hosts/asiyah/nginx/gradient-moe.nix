/*

  Public gradient.moe website.

*/
{ self, pkgs, ... }:
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

}