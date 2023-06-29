{ ... }:
let
  ports = import ./misc/service-ports.nix;
in {

  services.grafana = {
    enable = true;
    settings.server = {
      http_addr = "127.0.0.1";
      http_port = ports.grafana;
      serve_from_sub_path = true;
      root_url = "%(protocol)s://%(domain)s:%(http_port)s/grafana/";
    };
  };

}