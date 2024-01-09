{ self, config, lib, ... }:
let
  ports = import misc/service-ports.nix;
  ips = import ../../misc/wireguard-addresses.nix;
  oauth2-config = ''
    auth_request https://polycule.constellation.moe/oauth2/auth;
    error_page 401 = https://polycule.constellation.moe/oauth2/sign_in;

    # pass information via X-User and X-Email headers to backend,
    # requires running with --set-xauthrequest flag
    auth_request_set $user   $upstream_http_x_auth_request_user;
    auth_request_set $email  $upstream_http_x_auth_request_email;
    proxy_set_header X-User  $user;
    proxy_set_header X-Email $email;

    # if you enabled --cookie-refresh, this is needed for it to work with auth_request
    auth_request_set $auth_cookie $upstream_http_set_cookie;
    add_header Set-Cookie $auth_cookie;
  '';
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

      "constellation.moe" = {
        root = self.inputs.constellation-moe;
        enableACME = true;
        addSSL = true;
        serverAliases = [
          "www.constellation.moe"
        ];
      };

      "polycule.constellation.moe" = {
        root = self.inputs.constellation-moe;
        enableACME = true;
        addSSL = true;
      };

      "stream.constellation.moe" = 
      let 
        vdo-ninja = self.inputs.vdo-ninja;
      in {
        root = vdo-ninja;
        enableACME = true;
        addSSL = true;
        locations."~ ^/([^/]+)/([^/?]+)$" = {
          extraConfig = ''
            ${oauth2-config}
            root ${vdo-ninja};
            try_files /$1/$2 /$1/$2.html /$1/$2/ /$2 /$2/ /$1/index.html;
            add_header Access-Control-Allow-Origin *;
          '';
        };
        locations."/" = {
          extraConfig = lib.mkForce ''
            ${oauth2-config}
            if ($request_uri ~ ^/(.*)\.html$) {
                    return 302 /$1;
            }
            try_files $uri $uri.html $uri/ /index.html;
            add_header Access-Control-Allow-Origin *;
          '';
        };
      };

      "neith.constellation.moe" = {
        enableACME = true;
        addSSL = true;

        locations."/" = {
          return = "301 https://constellation.moe$request_uri";
        };
        
        locations."/.well-known/discord" = {
          return = "200 dh=c6efaef2bdecf33aa37bf661e003f57442183211";
        };
      };

      "remie.constellation.moe" = {
        enableACME = true;
        addSSL = true;
        
        locations."/" = {
          return = "301 https://constellation.moe$request_uri";
        };

        locations."/.well-known/discord" = {
          return = "200 dh=1bcf1ec16a3b9abcf5df802a38bf0de78075303a";
        };
      };

      "vera.constellation.moe" = {
        enableACME = true;
        addSSL = true;
        
        locations."/" = {
          return = "301 https://constellation.moe$request_uri";
        };

        locations."/.well-known/discord" = {
          return = "200 dh=5d358d1a3d245e6375922193e53fdd0ab83b619b";
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