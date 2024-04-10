{ ... }:
{

  imports = [
    # WIP: ./mediamtx.nix
    ./backups.nix
    ./wireguard.nix
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

}