{ self, ... }:

{

  nix = {

    settings = {
      cores = 0;
      max-jobs = "auto";
      experimental-features = [ "nix-command" "flakes" ];
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
    };

  };

  environment.etc."nix/path/nixpkgs".source = self.inputs.nixpkgs;

}