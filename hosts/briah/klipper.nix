{ ... }:
let
  ports = import ./misc/service-ports.nix;
in {

  services.klipper = {
    enable = true;
    configFile = ./klipper.cfg;
    mutableConfig = true;
    octoprintIntegration = true;
  };

}