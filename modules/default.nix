# Dummy module that imports every other module here.
# Some of these require the "core" module.
{ ... }:
{

  imports = [
    ./kernel
    ./hardware
    ./profiles
    ./tmpfiles-check.nix
  ];

}