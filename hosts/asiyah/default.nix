{ config, ... }:
{

  imports = [
    # WIP: ./mediamtx.nix
    ./backups.nix
    ./grafana.nix
    ./duckdns.nix
    ./filesystem.nix
    ./dns-server.nix
    ./media-stack.nix
    ./nginx/default.nix
    ./palworld-server.nix
    ./secrets/default.nix
    ./redbot-stardream.nix
    ./gradient-generator.nix
    # ./project-zomboid-server.nix
    ./hardware-configuration.nix
    ./trilium-memory-repository.nix
  ];

  gradient.presets.syncthing.enable = true;

  gradient.substituters = {
    briah = "ssh-ng://nix-ssh@briah.gradient?priority=60";
    vera = "ssh-ng://nix-ssh@vera.gradient?priority=40";
    vera-deck = "ssh-ng://nix-ssh@vera-deck.gradient?priority=45";
    vera-deck-oled = "ssh-ng://nix-ssh@vera-deck-oled.gradient?priority=50";
    neith-deck = "ssh-ng://nix-ssh@neith-deck.lily?priority=100";
  };

  networking.hosts = with config.gradient.const.wireguard.addresses; {
    "${gradientnet.briah}" = [ "briah" ];
    "${gradientnet.miracle-crusher}" = [ "vera" ];
    "${gradientnet.vera-deck}" = [ "deck" ];
    "${gradientnet.vera-deck-oled}" = [ "deck-oled" ];
    "${gradientnet.vera-laptop}" = [ "laptop" ];
    "${lilynet.neith-deck}" = [ "neith-deck" ];
  };

}