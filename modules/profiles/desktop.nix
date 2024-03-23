{ config, lib, pkgs, ... }:
let
  cfg = config.gradient;
in
{

  options = {
    gradient.profiles.desktop.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Whether to enable the GradientOS desktop profile.
        Enables audio, graphics and some extras such as flatpak support.
      '';
    };
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.profiles.desktop.enable {
      gradient.profiles.audio.enable = true;
    })
  ];

}