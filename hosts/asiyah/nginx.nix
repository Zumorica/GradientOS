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
      "stream.gradient.moe" = 
      let 
        vdo-ninja = self.inputs.vdo-ninja;
      in {
        root = vdo-ninja;
        basicAuthFile = config.sops.secrets.stream-htpasswd.path;
        enableACME = true;
        addSSL = true;
        serverAliases = [
          "stream.zumorica.es"
        ];
        locations."~ ^/([^/]+)/([^/?]+)$" = {
          extraConfig = ''
            root ${vdo-ninja};
            try_files /$1/$2 /$1/$2.html /$1/$2/ /$2 /$2/ /$1/index.html;
            add_header Access-Control-Allow-Origin *;
          '';
        };
        locations."/" = {
          extraConfig = ''
            if ($request_uri ~ ^/(.*)\.html$) {
                    return 302 /$1;
            }
            try_files $uri $uri.html $uri/ /index.html;
            add_header Access-Control-Allow-Origin *;
          '';
        };
      };
      "gradientnet" = with ips.gradientnet; {
        listenAddresses = [ asiyah ];
        serverAliases = [
          "gradient"
          "asiyah"
          asiyah
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

        # locations."/grafana/" = let grafana = config.services.grafana.settings.server; in {
        #   proxyPass = "http://${toString grafana.http_addr}:${toString grafana.http_port}";
        #   proxyWebsockets = true;
        #   extraConfig = ''
        #     allow ${gradientnet}/24;
        #     deny all;
        #   '';
        # };

        # locations."/syncthing/" = {
        #   extraConfig = ''
        #     proxy_set_header        Host $host;
        #     proxy_set_header        X-Real-IP $remote_addr;
        #     proxy_set_header        X-Forwarded-For $proxy_add_x_forwarded_for;
        #     proxy_set_header        X-Forwarded-Proto $scheme;

        #     proxy_pass http://127.0.0.1:${toString ports.syncthing}/;

        #     proxy_read_timeout      600s;
        #     proxy_send_timeout      600s;
        #     allow ${gradientnet}/24;
        #     deny all;
        #   '';
        # };
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