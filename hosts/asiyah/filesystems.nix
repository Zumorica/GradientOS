{ ... }:
{

  fileSystems."/" =
    { device = "/dev/disk/by-label/nixos";
      fsType = "ext4";
    };

  fileSystems."/mnt/resource" =
    { device = "/dev/disk/by-uuid/5f9b9e9d-ad9d-4567-8e79-8db8241fc877";
      fsType = "ext4";
    };

  swapDevices = [ ];

}