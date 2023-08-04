{ ... }:
{

  imports = [
    ./secrets
    ./wireguard.nix
    ./filesystem.nix
    ./media-stack.nix
    ./hardware-configuration.nix
  ];

}