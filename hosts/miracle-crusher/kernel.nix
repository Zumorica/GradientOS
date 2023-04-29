{ config, pkgs, nixpkgs-unstable, ... }:

{

  boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.kernelParams = [  ];

}