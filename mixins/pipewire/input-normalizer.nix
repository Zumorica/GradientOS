/*
*   Based on https://gitlab.com/echoa/pipewire-guides/-/tree/Pipewire-Filter-Chains_Normalize-Audio-and-Noise-Suppression
*/
{ pkgs, ... }:
{

  environment.etc
    ."pipewire/pipewire.conf.d/00-normalizer.conf"
    .text = ''
context.modules = [
{   name = libpipewire-module-filter-chain
    args = {
        node.description =  "Normalizer source"
        media.name =  "Normalizer source"
        filter.graph = {
            nodes = [
                {
                    type = ladspa
                    name = compressor
                    plugin = ${"${pkgs.ladspaPlugins}/lib/ladspa/sc4_1882.so"}
                    label = sc4
                    control = {
                        "RMS/peak" = 0.0
                        "Attack time (ms)" = 60
                        "Release time (ms)" = 600
                        "Threshold level (dB)" = -5
                        "Ratio (1:n)" = 15
                        "Knee radius (dB)" = 2
                        "Makeup gain (dB)" = 4
                    }
                }
                {
                    type = ladspa
                    name = limiter
                    plugin = ${"${pkgs.ladspaPlugins}/lib/ladspa/fast_lookahead_limiter_1913.so"}
                    label = fastLookaheadLimiter
                    control = {
                        "Input gain (dB)" = 0
                        "Limit (dB)" = -20
                        "Release time (s)" = 0.8
                    }
                }
            ]
            links = [
                { output = "compressor:Left output" input = "limiter:Input 1" }
                { output = "compressor:Right output" input = "limiter:Input 2" }
            ]
            inputs  = [ "compressor:Left input" "compressor:Right input" ]
            outputs = [ "limiter:Output 1" "limiter:Output 2" ]
        }
        audio.position = [ FL FR ]
        capture.props = {
            node.name =  "capture.normalizer_source"
            node.passive = true
            audio.rate = 48000
        }
        playback.props = {
            node.name =  "normalizer_source"
            media.class = "Audio/Source"
            media.role = "Communication"
            audio.rate = 48000
        }
    }
}
]
    '';

}