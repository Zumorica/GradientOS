{ self, ... }:

{

  nix = {

    settings = {
      cores = 0;
      max-jobs = "auto";
      experimental-features = [ "nix-command" "flakes" ];
      keep-outputs = true;
      keep-derivations = true;

      substituters = [
        "https://nix-gaming.cachix.org"
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

    nixPath = [ "/etc/nix/path" ];

    registry = {
      self.flake = self;
      nixpkgs.flake = self.inputs.nixpkgs;
      nixpkgs-stable-2211.flake = self.inputs.nixpkgs-stable-2211;
      nixpkgs-stable-2305.flake = self.inputs.nixpkgs-stable-2305;
    };

  };

  environment.etc."nix/path/nixpkgs".source = self.inputs.nixpkgs;

}