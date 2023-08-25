{ self, ... }:

{

  imports = [
    self.inputs.nixos-hardware.nixosModules.raspberry-pi-4
  ];

  boot.loader.raspberryPi.firmwareConfig = ''
    dtoverlay=dwc2
  '';

}