{ config, lib, pkgs, ... }:

{

  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  environment.systemPackages = with pkgs; [
    ryzenadj
    zenstates
  ];

}