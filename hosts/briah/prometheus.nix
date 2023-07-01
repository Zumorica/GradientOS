{ ... }:
let
  ports = import ./misc/service-ports.nix;
in {

  services.prometheus = {
    enable = true;
    port = ports.prometheus;

    exporters = {
      node = {
        enable = true;
        enabledCollectors = [ "systemd" ];
        port = ports.prometheus-exporter-node;
      };
    };

    scrapeConfigs = [
      {
        job_name = "briah";
        static_configs = [
          { targets = [ "127.0.0.1:${toString ports.prometheus-exporter-node}" ]; }
        ];
      }
    ];
  };

}