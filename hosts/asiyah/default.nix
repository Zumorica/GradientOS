{ config, ... }:
{

  imports = [
    # WIP: ./mediamtx.nix
    ./backups.nix
    ./grafana.nix
    ./duckdns.nix
    ./filesystem.nix
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
    bernkastel = "ssh-ng://nix-ssh@bernkastel.gradient?priority=40";
    vera-deck = "ssh-ng://nix-ssh@vera-deck.gradient?priority=45";
    erika = "ssh-ng://nix-ssh@erika.gradient?priority=50";
    neith-deck = "ssh-ng://nix-ssh@neith-deck.lily?priority=100";
  };
  
}