{ pkgs, ... }:

{

  environment.systemPackages = with pkgs; [ direnv nix-direnv ];
  nix.settings = {
    keep-outputs = true;
    keep-derivations = true;
  };
}