{ self, config, ... }:
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
      "gradientnet" = with ips.gradientnet; {
        listenAddresses = [ briah ];
        serverAliases = [
          "gradient"
          "briah"
          briah
        ];
        
        locations."/memory_repository/" = {
          proxyPass = "http://127.0.0.1:${toString ports.trilium}/";
          extraConfig = ''
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto $scheme;
            proxy_set_header Upgrade $http_upgrade;
            proxy_set_header Connection "upgrade";
            proxy_http_version 1.1;
            proxy_read_timeout 90;
            allow ${gradientnet}/24;
            deny all;
          '';
        };

        locations."/grafana/" = let grafana = config.services.grafana.settings.server; in {
          proxyPass = "http://${toString grafana.http_addr}:${toString grafana.http_port}";
          proxyWebsockets = true;
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