{ config, pkgs, lib, self, ... }:
let
  cfg = config.gradient;
in
{

  options = {
    gradient.core.nix.enable = lib.mkOption {
      type = lib.types.bool;
      default = cfg.gradient.core.enable;
      description = ''
        Whether to enable Nix-specific core GradientOS configurations.
      '';
    };

    gradient.core.nix.emptyGlobalFlakeRegistry = lib.mkOption {
      type = lib.types.bool;
      default = cfg.gradient.core.nix.enable;
      description = ''
        Whether to empty the global flake registry.
      '';
    };

    gradient.core.nix.pinChannelsToFlakeInputs = lib.mkOption {
      type = lib.types.bool;
      default = cfg.gradient.core.nix.enable;
      description = ''
        Whether to enable pinning channels to various GradientOS flake inputs, such as nixpgks.
      '';
    };
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.core.nix.enable {
      nix =
      {

        package = pkgs.nixVersions.unstable;

        settings = {
          cores = 0;
          max-jobs = "auto";
          experimental-features = [ "nix-command" "flakes" ];
          keep-outputs = true;
          keep-derivations = true;

          substituters = [
            "https://nix-gaming.cachix.org?priority=100"
            "https://nix-community.cachix.org?priority=100"
            # "https://0uptime.cachix.org?priority=100"
          ];

          trusted-public-keys = [
            "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
            "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
            # "0uptime.cachix.org-1:ctw8yknBLg9cZBdqss+5krAem0sHYdISkw/IFdRbYdE="
          ];
          
          trusted-users = [
            "root"
            "@wheel"
          ];

        };

        gc = {
          automatic = true;
          persistent = true;
          dates = "15:00";
          options = "--delete-older-than 7d";
        };

        optimise = {
          automatic = true;
          dates = [ "weekly" ];
        };

      };
    })
    
    (lib.mkIf cfg.core.nix.emptyGlobalFlakeRegistry {
        nix.flake-registry = builtins.toFile "empty-registry.json" ''{"flakes": [], "version": 2}'';
    })

    (lib.mkIf cfg.core.nix.pinChannelsToFlakeInputs {
      # Pin channels to flake inputs.
      nix.registry.nixpkgs.flake = self.inputs.nixpkgs;
      nix.registry.nixpkgs-stable.flake = self.inputs.nixpkgs-stable;
      nix.registry.self.flake = self;

      environment.etc."nix/inputs/nixpkgs".source = "${self.inputs.nixpkgs}";
      environment.etc."nix/inputs/nixpkgs-stable".source = "${self.inputs.nixpkgs-stable}";
      environment.etc."nix/inputs/self".source = "${self}";

      nix.nixPath = [ "/etc/nix/inputs" ];
    })
  ];

}