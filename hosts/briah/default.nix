{ lib, ... }:
{

  imports = [
    ./secrets
    ./nginx.nix
    ./loki.nix
    ./duckdns.nix
    ./grafana.nix
    ./promtail.nix
    ./wireguard.nix
    ./prometheus.nix
    ./containers.nix
    ./filesystems.nix
    ./trilium-memory-repository.nix
  ];

}