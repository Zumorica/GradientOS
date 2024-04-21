{ config, ... }:
{

  imports = [
    # WIP: ./mediamtx.nix
    ./backups.nix
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

  networking.hosts = with config.gradient.const.wireguard.addresses; {
    "${gradientnet.briah}" = [ "briah" ];
    "${gradientnet.miracle-crusher}" = [ "vera" ];
    "${gradientnet.vera-deck}" = [ "deck" ];
    "${gradientnet.vera-deck-oled}" = [ "deck-oled" ];
    "${gradientnet.vera-laptop}" = [ "laptop" ];
    "${lilynet.neith-deck}" = [ "lily" "neith" ];
  };

}