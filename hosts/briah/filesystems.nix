{ ... }:
{
  boot.loader.grub.enable = false;

  fileSystems."/" = {
    device = "/dev/disk/by-label/NIXOS_SD";
    fsType = "ext4";
    mountPoint = "/";
  };

  # Stupid HDD died TODO: replace by a new one
  #fileSystems."/data" = {
  #  device = "/dev/disk/by-uuid/bf3b5f82-b859-4b22-9192-918e01ea7af1";
  #  fsType = "ext4";
  #  options = [ "rw" "auto" "noatime" "nofail" ];
  #};

  swapDevices = [
    #{
    #  device = "/data/swapfile";
    #  size = 16*1024;
    #}
  ];

}