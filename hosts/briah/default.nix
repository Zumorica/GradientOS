{ lib, ... }:
{

  imports = [
    ./wireguard.nix
    ./containers.nix
    ./filesystems.nix
    ./trilium-memory-repository.nix
  ];

  # Forcibly disable NetworkManager.
  networking.networkmanager.enable = lib.mkForce false;


}