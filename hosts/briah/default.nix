{ ... }:
{

  imports = [
    ./secrets
    ./loki.nix
    ./duckdns.nix
    ./grafana.nix
    ./promtail.nix
    ./syncthing.nix
    ./wireguard.nix
    ./prometheus.nix
    ./containers.nix
    ./filesystems.nix
    # ./ss14-watchdog.nix
  ];

}