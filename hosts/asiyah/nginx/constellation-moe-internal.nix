{ self, ... }:
let
  ports = import ../misc/service-ports.nix;
  oauth2-config = ''
    auth_request /oauth2/auth;
    error_page 401 = /oauth2/sign_in;
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

  services.nginx.virtualHosts."polycule.constellation.moe" = {
    root = self.inputs.constellation-moe;
    enableACME = true;
    addSSL = true;
    extraConfig = ''
      # Set for whole server.
      ${oauth2-config}
    '';

    locations."/oauth2/".extraConfig = ''
      auth_request off;
    '';

    locations."/oauth2/auth".extraConfig = ''
      auth_request off;
    '';

    locations."/stream/" = {
      proxyPass = "http://127.0.0.1:${toString ports.vdo-ninja}/";
      proxyWebsockets = true;
      extraConfig = ''
        add_header Access-Control-Allow-Origin *;
      '';
    };
  };
  
}