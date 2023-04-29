{ ... }:

{

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  fileSystems."/" = 
  { device = "/dev/null"; # TODO
    fsType = "ext4";
  };

  fileSystems."/boot/efi" =
  { device = "/dev/null"; # TODO
    fsType = "vfat";
  };

    swapDevices =
    [ { device = "/dev/null"; } # TODO
    ];

}