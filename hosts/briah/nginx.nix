{ self, ... }:
let
  ports = import misc/service-ports.nix;
  ips = import ../../misc/wireguard-addresses.nix;
in {

  services.nginx = {
    enable = true;

    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;

    virtualHosts = {
      "gradient.moe" = {
        root = self.inputs.gradient-moe;
        enableACME = true;
        forceSSL = true;
        serverAliases = [
          "www.gradient.moe"
          "zumorica.es"
          "www.zumorica.es"
        ];
      };
      "gradientnet" = {
        listenAddresses = [ (toString ips.gradientnet.briah) ];
        locations."memory_repository" = {
          proxyPass = "http://127.0.0.1:${toString ports.trilium}";
          extraConfig = ''
            proxy_http_version 1.1;
            proxy_set_header Upgrade $http_upgrade;
            proxy_set_header Connection 'upgrade';
            proxy_set_header Host $host;
            proxy_cache_bypass $http_upgrade;
            allow ${ips.gradientnet.gradientnet}/24;
            deny all;
          '';
        };
      };
    };
  };

  security.acme = {
    acceptTerms = true;
    defaults = {
      email = "gradientvera+acme@outlook.com";
    };
  };

  networking.firewall.allowedTCPPorts = with ports; [
    gradient-moe gradient-moe-secure
  ];

}