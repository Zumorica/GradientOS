{ self, pkgs, lib, ... }:
let
  flakes = lib.attrsets.filterAttrs (_: v: (v.flake or true) == true) self.inputs;
in {

  nix = {

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
      ];

      trusted-public-keys = [
        "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
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

    # Pin channels to flake inputs.
    nixPath = (lib.attrsets.mapAttrsToList (x: _: "${x}=flake:${x}") flakes) ++ [ "self=flake:self" ];
    registry = (lib.attrsets.mapAttrs (_: flake: { inherit flake; }) flakes) // { self.flake = self; };

  };
}