{ self, lib, ... }:

{

  imports = [
    ./nixos.nix
  ];

  system.configurationRevision = lib.mkIf (self ? rev) self.rev;
  system.autoUpgrade.flake = "github:Zumorica/GradientOS";

}