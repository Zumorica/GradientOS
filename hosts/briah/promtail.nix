{ ... }:
let
  ports = import ./misc/service-ports.nix;
in {

  services.promtail = {
    enable = true;
    configuration = {
      server = {
        http_listen_port = ports.promtail;
        grpc_listen_port = 0;
      };

      positions = {
        filename = "/tmp/positions.yml";
      };

      clients = [
        { url = "http://127.0.0.1:${toString ports.loki}/loki/api/v1/push"; }
      ];

      scrape_configs = [
        {
          job_name = "journal";
          journal = {
            max_age = "12h";
            labels = {
              job = "systemd-journal";
              host = "briah";
            };
          };
          relabel_configs = [
            {
              source_labels = [ "__journal__systemd_unit" ];
              target_label = "unit";
            }
          ];
        }
      ];
    };
  };

}