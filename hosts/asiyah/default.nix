{ ... }:
{

  imports = [
    ./secrets
    ./nginx.nix
    ./wireguard.nix
    ./filesystem.nix
    ./media-stack.nix
    # ./project-zomboid.nix
    ./redbot-stardream.nix
    ./gradient-generator.nix
    ./hardware-configuration.nix
    ./trilium-memory-repository.nix
  ];

}