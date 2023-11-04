{ pkgs, lib, ... }:
{
  nix =
  {

    package = pkgs.nixVersions.unstable;

    settings = {
      cores = 0;
      max-jobs = "auto";
      experimental-features = [ "nix-command" "flakes" ];
      keep-outputs = true;
      keep-derivations = true;

      # Ignore global flake registry
      flake-registry = builtins.toFile "empty-registry.json" ''{"flakes": [], "version": 2}'';

      substituters = [
        "https://nix-gaming.cachix.org?priority=100"
        "https://nix-community.cachix.org?priority=100"
      ];

      trusted-public-keys = [
        "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
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
}