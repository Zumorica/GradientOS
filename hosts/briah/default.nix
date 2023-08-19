{ pkgs, ... }:
{

  imports = [
    ./secrets
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
    ./hardware-configuration.nix
  ];

}