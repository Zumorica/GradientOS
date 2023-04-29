{ pkgs, ... }:

{

  # Enable hardware and Steam support.
  jovian.devices.steamdeck.enable = true;
  jovian.steam.enable = true;

  # Add some useful packages.
  environment.systemPackages = with pkgs; [
    mangohud
    steamdeck-firmware
    jupiter-dock-updater-bin
  ];

  # Automount SD card.
  fileSystems."/run/media/deck/mmcblk0p1" = {
    device = "/dev/mmcblk0p1";
    options = [ "defaults" "rw" "nofail" "x-systemd.automount" "x-systemd.device-timeout=1ms" "comment=x-gvfs-show" ];
  };

}