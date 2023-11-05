{ pkgs, lib, ... }:

{

  specialisation.zen-kernel.configuration = {
    boot.kernelPackages = lib.mkForce pkgs.linuxPackages_zen;
  };

  boot.kernelPackages = pkgs.linuxKernel.packages.linux_6_5;
  
  boot.kernelParams = [  ];

}