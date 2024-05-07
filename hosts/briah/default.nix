{ config, pkgs, ... }:
{

  imports = [
    #./loki.nix
    ./backups.nix
    ./klipper.nix
    ./duckdns.nix
    #./grafana.nix
    ./programs.nix
    ./mainsail.nix
    #./octoprint.nix
    ./moonraker.nix
    ./ustreamer.nix
    #./promtail.nix
    #./syncthing.nix
    #./prometheus.nix
    #./containers.nix
    ./filesystems.nix
    # ./ss14-watchdog.nix
    ./kiosk-session.nix
    ./secrets/default.nix
  ];

  gradient.substituters = {
    asiyah = "ssh-ng://nix-ssh@asiyah.gradient?priority=40";
    vera = "ssh-ng://nix-ssh@vera.gradient?priority=40";
    vera-deck-oled = "ssh-ng://nix-ssh@vera-deck-oled.gradient?priority=50";
    neith = "ssh-ng://nix-ssh@neith.lily?priority=100";
  };

  boot.loader.raspberryPi.firmwareConfig = ''
    arm_64bit=1
    gpu_mem=256
    hdmi_force_hotplug=1
  '';
  
  networking.hosts = with config.gradient.const.wireguard.addresses; {
    "${gradientnet.asiyah}" = [ "asiyah" ];
    "${gradientnet.miracle-crusher}" = [ "vera" ];
    "${gradientnet.vera-deck}" = [ "deck" ];
    "${gradientnet.vera-deck-oled}" = [ "deck-oled" ];
    "${lilynet.neith-deck}" = [ "lily" "neith" ];
  };

}