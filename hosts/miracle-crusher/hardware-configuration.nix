{ modulesPath, ... }:

{

  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" "amdgpu" "xhci_hcd" ];
  boot.initrd.kernelModules = [ "amdgpu" ];
  boot.kernelModules = [ "kvm-amd" "i2c-dev" "i2c-piix4" ];
  boot.kernelParams = [
    # iommu stuff
    "amd_iommu=on"
    "iommu=pt"
    "iommu=1"
    "video=efifb:off"

    # needed for controlling RGB LEDs on RAM sticks supposedly
    "acpi_enforce_resources=lax"
  ];
  boot.extraModulePackages = [ ];

  nixpkgs.hostPlatform = "x86_64-linux";

}

