{ pkgs, ... }:
{

  imports = [
    #./loki.nix
    ./klipper.nix
    ./duckdns.nix
    #./grafana.nix
    ./programs.nix
    ./octoprint.nix
    ./ustreamer.nix
    #./promtail.nix
    ./syncthing.nix
    ./wireguard.nix
    ./prometheus.nix
    #./containers.nix
    ./filesystems.nix
    # ./ss14-watchdog.nix
    ./secrets/default.nix
    ./octoprint-session.nix
  ];

  boot.loader.raspberryPi.firmwareConfig = ''
    arm_64bit=1
    gpu_mem=256
    hdmi_force_hotplug=1
  '';
  
}