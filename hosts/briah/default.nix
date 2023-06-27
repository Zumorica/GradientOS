{ lib, ... }:
{

  imports = [
    ./secrets
    ./nginx.nix
    ./wireguard.nix
    ./containers.nix
    ./filesystems.nix
    ./trilium-memory-repository.nix
  ];

}