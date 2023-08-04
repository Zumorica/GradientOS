{ ... }:
{

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/64bf0904-8981-4e37-af05-c4cd43872db5";
    fsType = "ext4";
  };

  fileSystems."/data" = {
    device = "/dev/disk/by-uuid/e8dac6e2-b559-4382-817d-4382a41b6c38";
    fsType = "ext4";
  };

  fileSystems."/boot" = { 
    device = "/dev/disk/by-uuid/06C6-4997";
    fsType = "vfat";
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/7ffb0ba5-18de-469a-81c7-e66108357512"; priority = 100; }
    { device = "/dev/disk/by-uuid/1e460ca4-2612-43b3-9ca5-941592a9a98b"; priority = 50; }
  ];

}