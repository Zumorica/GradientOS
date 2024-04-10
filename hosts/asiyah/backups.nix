{ ... }:
{

  services.restic.backups.hokma = {
    paths = [
      "/home/vera"
      "/data/trilium"
      "/data/stardream"
      "/data/gradient-data"
    ];
  };

}