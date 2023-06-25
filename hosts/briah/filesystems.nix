{ ... }:
{

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  fileSystems."/" = {
    # TODO
    device = "/dev/disk/by-label/NIXOS_SD";
    fsType = "ext4";
  };

  fileSystems."/data" = {
    device = "/dev/disk/by-uuid/bf3b5f82-b859-4b22-9192-918e01ea7af1";
    fsType = "ext4";
    options = [ "rw" "auto" "noatime" "nofail" ];
  };

}