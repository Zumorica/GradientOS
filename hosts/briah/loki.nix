{ pkgs, ... }:
let
  ports = import ./misc/service-ports.nix;
in {

  services.loki = {
    enable = true;
    configFile = pkgs.writeText "loki-config" (builtins.toJSON {
      auth_enabled = false;

      server = {
        http_listen_port = ports.loki;
      };

      common = {
        instance_addr = "127.0.0.1";
        path_prefix = "/tmp/loki";
        storage = {
          filesystem = {
            chunks_directory = "/tmp/loki/chunks";
            rules_directory = "/tmp/loki/rules";
          };
        };
        replication_factor = 1;
        ring = {
          kvstore = {
            store = "inmemory";
          };
        };
      };

      query_range = {
        results_cache = {
          cache = {
            embedded_cache = {
              enable = true;
              max_size_mb = 100;
            };
          };
        };
      };

      schema_configs = {
        configs = [
          {
            from = "2020-10-24";
            store = "boltdb-shipper";
            object_store = "filesystem";
            schema = "v11";
            index = {
              prefix = "index_";
              period = "24h";
            };
          }
        ];
      };

      ruler = {
        alertmanager_url = "http://localhost:${toString ports.loki-alert-manager}";
        reporting_enabled = false;
      };
    });
  };

}