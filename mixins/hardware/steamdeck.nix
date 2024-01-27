{ pkgs, ... }:

{

  # Enable hardware and Steam support.
  jovian.devices.steamdeck.enable = true;
  jovian.devices.steamdeck.autoUpdate = true;
  jovian.steam.enable = true;

  # Requires enabling CEF remote debugging on the Developer menu settings to work.
  jovian.decky-loader.enable = true;

  # In case you use disk encryption.
  boot.initrd.unl0kr.enable = true;

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

  # Symlink old Steam Deck SD card path to new one.
  systemd.tmpfiles.rules = [ "L+ /run/media/mmcblk0p1 - - - - /run/media/deck/mmcblk0p1" ];

}
