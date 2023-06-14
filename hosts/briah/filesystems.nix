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

}