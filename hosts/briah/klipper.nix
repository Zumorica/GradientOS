{ ... }:
{

  services.klipper = {
    enable = true;
    configFile = ./klipper.cfg;
    mutableConfig = true;
    octoprintIntegration = true;
    logFile = "/var/lib/klipper/klipper.log";
  };

}