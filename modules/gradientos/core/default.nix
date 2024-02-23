{ config, lib, self, ... }:
let
  cfg = config.gradient;
in  
{

  imports = [
    ./nix.nix
    ./nixos.nix
  ];

  options = {
    gradient.core.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Whether to enable the core GradientOS configuration.
      '';
    };
  };

  config = lib.mkIf cfg.core.enable {
    system.configurationRevision = lib.mkIf (self ? rev) self.rev;
    system.autoUpgrade.flake = "github:Zumorica/GradientOS";
  };

}