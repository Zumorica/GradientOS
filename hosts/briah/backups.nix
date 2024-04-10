{ ... }:
{

  services.restic.backups.hokma = {
    paths = [
      "/home/vera"
      "/var/lib/klipper"
    ];
  };

}