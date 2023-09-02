{ pkgs, ... }:
{

  imports = [
    ./loki.nix
    ./duckdns.nix
    ./grafana.nix
    ./programs.nix
    ./promtail.nix
    ./syncthing.nix
    ./wireguard.nix
    ./prometheus.nix
    ./containers.nix
    ./filesystems.nix
    # ./ss14-watchdog.nix
    ./secrets/default.nix
  ];

}