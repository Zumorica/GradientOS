{ ... }:
{

  imports = [
    ./secrets
    ./nginx.nix
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
    ./redbot-stardream.nix
    ./trilium-memory-repository.nix
  ];

}