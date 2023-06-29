{ lib, ... }:
{

  imports = [
    ./secrets
    ./nginx.nix
    ./grafana.nix
    ./wireguard.nix
    ./containers.nix
    ./filesystems.nix
    ./trilium-memory-repository.nix
  ];

}