{ ... }:
{

  services.pipewire.extraConfig.pipewire."99-virtual-sink.conf" = {
    "context.modules" = [
        {   "name" = "libpipewire-module-loopback";
            "args" = {
                "node.description" = "Virtual Sink";
                "media.name" = "Virtual Sink";
                "capture.props" = {
                    "audio.position" = [ "FL" "FR" ];
                    "media.class" = "Audio/Sink";
                };
                "playback.props" = {
                    "audio.position" = [ "FL" "FR" ];
                    "stream.dont-remix" = true;
                    "node.passive" = true;
                    "media.class" = "Audio/Source";
                    "media.role" = "Communication";
                };
            };
        }
    ];
  };
    
}