{ self, pkgs, ... }:

{

  nix = {

    package = pkgs.nixVersions.unstable;

    settings = {
      cores = 0;
      max-jobs = "auto";
      experimental-features = [ "nix-command" "flakes" ];
      keep-outputs = true;
      keep-derivations = true;

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

    nixPath = [ 
      "self=/etc/nixpath/self"
      "nixpkgs=/etc/nixpath/nixpkgs"
    ];

    registry = {
      self.flake = self;
      nixpkgs.flake = self.inputs.nixpkgs;
      nixpkgs-stable-2211.flake = self.inputs.nixpkgs-stable-2211;
      nixpkgs-stable-2305.flake = self.inputs.nixpkgs-stable-2305;
    };

  };

  environment.etc."nixpath/self".source = self;
  environment.etc."nixpath/nixpkgs".source = self.inputs.nixpkgs;

}