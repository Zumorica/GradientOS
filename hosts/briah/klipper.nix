{ config, ... }:
{

  services.klipper = {
    enable = true;
    user = config.services.moonraker.user;
    group = config.services.moonraker.group;
    configFile = ./klipper.cfg;
    mutableConfig = true;
    logFile = "/var/lib/klipper/klipper.log";
  };

}