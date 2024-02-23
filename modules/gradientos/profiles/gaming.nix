{ config, lib, pkgs, ... }:
let
  cfg = config.gradient;
in 
{

  options = {
    gradient.profiles.gaming.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Whether to enable the GradientOS gaming profile.
        Includes some common videogames and nice performance tweaks.
      '';
    };
  };

  config = lib.mkIf cfg.profiles.gaming.enable {
    # Performance tweaks based on CryoUtilities
    gradient.kernel = {
      hugepages = {
        enable = true;
        defrag = "0";
        sharedMemory = "advise";
      };
      swappiness = 1;
      pageLockUnfairness = 1;
      compactionProactiveness = 0;
    };

    environment.systemPackages = with pkgs; [
      space-station-14-launcher
      prismlauncher
      dolphin-emu
      xivlauncher
      steam-run
      heroic
      lutris
    ];
  };

}