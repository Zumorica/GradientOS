/*
  Don't forget to add folders to back-up on your host-specific config after importing this!
*/
{ config, ... }:
let
  secrets = config.sops.secrets;
in
{

  services.restic.backups.hokma = {
    initialize = true;
    passwordFile = secrets.hokma-password.path;
    environmentFile = secrets.hokma-environment.path;
    repository = "azure:backup:/";
    
    timerConfig = {
      OnCalendar = "Mon *-*-* 10:00:00";
    };

    # Set these on your host!
    paths = [];
    exclude = [];
  };

  sops.secrets = 
  let
    secretCfg = { restartUnits = [ "restic-backups-hokma.service" ]; };
  in {
    hokma-password = secretCfg;
    hokma-environment = secretCfg;
  };

}