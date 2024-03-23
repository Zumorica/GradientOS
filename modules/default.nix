# Dummy module that imports every other module here.
# Some of these require the "core" module.
{ ... }:
{

  imports = [
    ./kernel
    ./hardware
    ./profiles
    # WIP: ./wireguard.nix
    ./tmpfiles-check.nix
  ];

}