# Dummy module that imports every other module.
{ ... }:
{

  imports = [
    ./gradientos
    ./tmpfiles-check.nix
  ];

}