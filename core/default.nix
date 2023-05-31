{ self, ... }:

{

  imports = [
    ./nixos.nix
  ];

  system.configurationRevision = self.rev;
  system.autoUpgrade.flake = "github:Zumorica/GradientOS";

}