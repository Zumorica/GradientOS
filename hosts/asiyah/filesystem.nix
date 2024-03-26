{ ... }:
{

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.grub.enable = false;
  boot.loader.efi.canTouchEfiVariables = true;

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/599884aa-ad46-44e0-8616-3ef644cf6fab";
    fsType = "ext4";
    mountPoint = "/";
  };

  fileSystems."/data" = {
    device = "/dev/disk/by-uuid/e8dac6e2-b559-4382-817d-4382a41b6c38";
    fsType = "ext4";
    mountPoint = "/data";
  };

  fileSystems."/boot" = { 
    device = "/dev/disk/by-uuid/2B43-E0C0";
    fsType = "vfat";
    mountPoint = "/boot";
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/57eb5b85-fd37-4345-ba94-5ac155c89a46"; priority = 100; }
    { device = "/dev/disk/by-uuid/1e460ca4-2612-43b3-9ca5-941592a9a98b"; priority = 50; }
  ];

}