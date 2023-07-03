{ config, ... }:
{

  virtualisation.oci-containers.containers.stardream = {
    image = "phasecorex/red-discordbot:core-audio-py311";
    volumes = [ "/data/stardream:/data" ];
    environment = {
      TZ = config.time.timeZone;
      OWNER = "132502019981180928";
      EXTRA_ARGS = "--dev";
    };
  };

}