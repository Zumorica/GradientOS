{ pkgs, ... }:
{

  imports = [
    #./loki.nix
    ./klipper.nix
    ./duckdns.nix
    #./grafana.nix
    ./programs.nix
    #./promtail.nix
    ./syncthing.nix
    ./wireguard.nix
    ./prometheus.nix
    #./containers.nix
    ./filesystems.nix
    # ./ss14-watchdog.nix
    ./secrets/default.nix
  ];

  boot.loader.raspberryPi.firmwareConfig = ''
    dtoverlay=dwc2
    gpu_mem=256
  '';
  
}