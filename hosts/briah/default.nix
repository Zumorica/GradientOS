{ ... }:
{

  imports = [
    ./wireguard.nix
    ./containers.nix
    ./filesystems.nix
    ./hardware-configuration.nix
    ./trilium-memory-repository.nix
  ];

}