{ ... }:

{

  imports = [
    ./nix.nix
    ./nix-direnv.nix
  ];

  systemd.user.startServices = true;
  
  nixpkgs.config = import ./misc/nixpkgs-config.nix;
  xdg.configFile."nixpkgs/config.nix".source = ./misc/nixpkgs-config.nix;
  
}