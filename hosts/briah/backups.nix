{ config, ... }:
{

  services.restic.backups.hokma = {
    paths = [
      "/home/vera"
      config.services.home-assistant.configDir
    ];
  };

}