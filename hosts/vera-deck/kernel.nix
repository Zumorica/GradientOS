{ pkgs, ... }:
{

  specialisation.linux-zen.configuration = {
    jovian.devices.steamdeck.enableKernelPatches = false;
    boot.kernelPackages = pkgs.linuxPackages_zen;
  };

}