{ config, pkgs, ... }:
{

  imports = [
    ./backups.nix
    ./programs.nix
    ./filesystems.nix
    ./home-assistant.nix
    # ./ss14-watchdog.nix
    ./secrets/default.nix
  ];

  gradient.presets.syncthing.enable = true;
  gradient.profiles.catppuccin.enable = true;

  gradient.substituters = {
    asiyah = "ssh-ng://nix-ssh@asiyah.gradient?priority=40";
    bernkastel = "ssh-ng://nix-ssh@bernkastel.gradient?priority=40";
    beatrice = "ssh-ng://nix-ssh@beatrice.gradient?priority=45";
    erika = "ssh-ng://nix-ssh@erika.gradient?priority=50";
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

}