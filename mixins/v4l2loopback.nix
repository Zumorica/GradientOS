{ config, pkgs, ... }:
{

  boot.extraModulePackages = with config.boot.kernelPackages; [
    v4l2loopback
  ];

  environment.systemPackages = [
    pkgs.v4l-utils
  ];

  boot.kernelModules = [ "v4l2loopback" ];

}