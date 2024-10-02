{ ... }:
{

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices."luks-4b159de8-a815-46ef-94bd-52a9d0e03e3a".device = "/dev/disk/by-uuid/4b159de8-a815-46ef-94bd-52a9d0e03e3a";
  boot.initrd.luks.devices."luks-5300f6ce-cc89-429c-8656-50e5bf71f13d".device = "/dev/disk/by-uuid/5300f6ce-cc89-429c-8656-50e5bf71f13d";

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "thunderbolt" "usb_storage" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/5931ef19-0224-4c5d-820b-269facdfa31b";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/B871-5205";
    fsType = "vfat";
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/08db435c-35ee-41ab-9373-e69a575e9955"; }
  ];

}