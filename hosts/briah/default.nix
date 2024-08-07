{ config, pkgs, ... }:
{

  imports = [
    ./backups.nix
    ./programs.nix
    #./syncthing.nix
    ./filesystems.nix
    # ./ss14-watchdog.nix
    ./secrets/default.nix
  ];

  gradient.substituters = {
    asiyah = "ssh-ng://nix-ssh@asiyah.gradient?priority=40";
    vera = "ssh-ng://nix-ssh@vera.gradient?priority=40";
    vera-deck = "ssh-ng://nix-ssh@vera-deck.gradient?priority=45";
    vera-deck-oled = "ssh-ng://nix-ssh@vera-deck-oled.gradient?priority=50";
    neith-deck = "ssh-ng://nix-ssh@neith-deck.lily?priority=100";
  };

  hardware.raspberry-pi."4".fkms-3d = {
    enable = true;
    cma = 256;
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
    "${lilynet.neith-deck}" = [ "neith-deck" ];
  };

}