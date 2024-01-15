/*

  Public gradient.moe website.

*/
{ self, ... }:
{

  services.nginx.virtualHosts."gradient.moe" = {
    root = self.inputs.gradient-moe;
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