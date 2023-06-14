{ modulesPath, ... }:
{

  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [ "usbhid" "usb_storage" ];

}